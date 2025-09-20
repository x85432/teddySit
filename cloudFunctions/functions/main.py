# 頂部引入和初始化部分

import firebase_admin # 引入 firebase_admin
from firebase_admin import credentials, firestore, auth
from firebase_functions import https_fn, params
from firebase_functions.options import set_global_options
import datetime
import json
import logging
import os
from uuid import uuid4
from datetime import datetime, timezone, timedelta


# backend funcitons
from scoreFunctions import calculate_cva
from scoreFunctions import calculate_tia

tz_utc8 = timezone(timedelta(hours=8))

# 確保 Firebase Admin SDK 在模組載入時初始化一次
# 這是確保 App Check 和其他 Firebase 服務在 Cloud Function 環境中正常工作的關鍵。
if not firebase_admin._apps: # 檢查是否已初始化，避免重複初始化
    firebase_admin.initialize_app()
    logging.info("Firebase app initialized globally.")
else:
    logging.info("Firebase app already initialized globally.")

# 每個 Cloud Function 最大同時實例數
set_global_options(max_instances=10)

# 全域變數
_db = None

# Secrets
API_KEY_SECRET = params.SecretParam('API_KEY')

# Firestore client 的懶惰初始化函數
def get_db():
    global _db
    if _db is None:
        try:
            _db = firestore.client() # 使用初始化後的 app 獲取 firestore client
            logging.info("Firestore client ready.")
        except Exception as e:
            logging.exception("Firestore client initialization failed: %s", e)
            raise RuntimeError("Firestore client initialization failed.") from e
    return _db

def serialize_datetime(doc: dict):
    """
    將 datetime 物件轉成 ISO 8601 字串，方便 JSON 序列化
    """
    for k, v in doc.items():
        if isinstance(v, datetime.datetime):
            doc[k] = v.isoformat()
    return doc

@https_fn.on_request(secrets=[API_KEY_SECRET])
def process_sensor_data(request: https_fn.Request):
    print("Cloud Function: 收到新請求。")
    expected_api_key = API_KEY_SECRET.value or os.environ.get('API_KEY')
    incoming_api_key = request.headers.get('X-API-Key')

    if not incoming_api_key or incoming_api_key != expected_api_key:
        print(f"未經授權的存取嘗試。收到金鑰：{incoming_api_key}")
        return https_fn.Response(
            json.dumps({'error': '未經授權'}),
            status=401,
            mimetype='application/json'
        )

    print("API 金鑰驗證成功。")

    # 解析 JSON
    try:
        request_json = request.get_json(silent=True)
        if not request_json:
            raise ValueError("無效的 JSON payload 或空請求體。")

        device_id = request_json.get('device_id')
        messages  = request_json.get('messages')

        if not device_id or not isinstance(messages, list):
            raise ValueError("Payload 中缺少 'device_id' 或 'messages' (必須是列表)。")
        
        print(f"接收到來自設備 '{device_id}' 的 {len(messages)} 條訊息。")
    except Exception as e:
        print(f"解析請求時發生錯誤：{e}")
        return https_fn.Response(
            json.dumps({'error': f'無效的請求 payload: {e}'}),
            status=400,
            mimetype='application/json'
        )

    # Firestore 寫入
    try:
        db = get_db()
        batch = db.batch()
        write_results = []

        for msg in messages:
            reading_timestamp = msg.get('timestamp')
            doc_id = f"{reading_timestamp}_{uuid4().hex}" if reading_timestamp else uuid4().hex
            
            # --- 核心改動區域: 處理並將資料分開寫入 ---
            landmarks = msg.get('landmarks')
            
            # 1. 計算分數
            cva_angle, cva_level = None, None
            tia_angle, tia_level = None, None
            frame_score, frame_accuracy = None, None

            if landmarks:
                cva_angle, cva_level = calculate_cva(landmarks)
                tia_angle, tia_level = calculate_tia(landmarks)
                
                if cva_level is not None and tia_level is not None:
                    frame_score = (cva_level + tia_level) / 2
                    frame_accuracy = ((frame_score - 1) / 3) * 100
            
            # 2. 準備要寫入的分數資料
            score_data = {
                "timestamp": datetime.now(tz_utc8),
                'cva_angle': cva_angle,
                'cva_level': cva_level,
                'tia_angle': tia_angle,
                'tia_level': tia_level,
                'frame_score': frame_score,
                'frame_accuracy': frame_accuracy
            }
            
            # 3. 定義兩個不同的文件參考
            raw_doc_ref   = db.collection('devices').document(device_id).collection('raw_data').document(doc_id)
            score_doc_ref = db.collection('devices').document(device_id).collection('scores').document(doc_id)
            
            # 4. 將原始資料和分數分別寫入批次
            batch.set(raw_doc_ref, msg)
            batch.set(score_doc_ref, score_data)
            
            write_results.append(f"為設備 '{device_id}' 添加訊息，文件 ID：{doc_id}")

        batch.commit()
        print(f"成功處理並寫入 {len(messages)} 條訊息到 Firestore。")
        return https_fn.Response(
            json.dumps({'status': 'success', 'message': f'成功處理 {len(messages)} 條記錄。', 'write_results': write_results}),
            status=200,
            mimetype='application/json'
        )
    except Exception as e:
        print(f"寫入 Firestore 時發生錯誤：{e}")
        return https_fn.Response(
            json.dumps({'error': f'寫入數據到 Firestore 失敗: {e}'}),
            status=500,
            mimetype='application/json'
        )

@https_fn.on_call()
def get_sensor_data_by_time_range(req: https_fn.CallableRequest) -> dict:
    try:
        data = req.data  # Flutter call 傳來的 JSON
        device_id = data.get('device_id')
        collection_name = data.get('collection_name', 'raw_data')
        start_time_str = data.get('start_time')
        end_time_str = data.get('end_time')

        if not device_id or not start_time_str or not end_time_str:
            raise ValueError("缺少必要參數")

        start_time_dt = datetime.fromisoformat(start_time_str.replace('Z', '+00:00'))
        end_time_dt   = datetime.fromisoformat(end_time_str.replace('Z', '+00:00'))

        db = firestore.client()
        query = (
            db.collection('devices')
              .document(device_id)
              .collection(collection_name)
              .where('timestamp', '>=', start_time_dt)
              .where('timestamp', '<=', end_time_dt)
              .order_by('timestamp', direction=firestore.Query.ASCENDING)
        )

        results = []
        for doc in query.stream():
            doc_data = doc.to_dict()
            ts = doc_data.get("timestamp")
            if isinstance(ts, datetime):
                doc_data["timestamp"] = ts.isoformat()
            elif isinstance(ts, (int, float)):
                dt = datetime.fromtimestamp(ts, tz=timezone.utc)
                doc_data["timestamp"] = dt.isoformat()
            results.append(doc_data)

        # ✅ return dict，不要 return Response
        return {"status": "success", "data": results}

    except Exception as e:
        return {"status": "error", "message": str(e)}