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

# backend funcitons
from scoreFunctions import calculate_cva
from scoreFunctions import calculate_tia

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
                'timestamp': reading_timestamp,
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

@https_fn.on_call(enforce_app_check=True) # 保持 App Check 啟用，用於 Flutter 客戶端
def do_not_disturb(req: https_fn.CallableRequest):
    print("Python Cloud Function 'do_not_disturb' was called (App Check enabled, Auth disabled, simulating userId).")
    
    # 由於你不需要 Firebase Authentication，我們移除 req.auth 的檢查。
    # App Check 會確保只有合法的應用程式可以呼叫這個函數。

    # **新的修改：如果沒有提供 userId，則生成一個模擬的 userId**
    user_id = req.data.get("userID") 
    if not user_id:
        # 如果客戶端沒有提供 userId，我們就生成一個隨機的 UUID 作為模擬的 userId
        user_id = f"simulated_user_{uuid4().hex}" 
        print(f"警告：客戶端未提供 userID。使用模擬 userID: {user_id}")
    else:
        print(f"客戶端提供的 userID: {user_id}")


    dnd_status = req.data.get("dnd_enabled", False)
    dnd_duration_hours = req.data.get("duration", 0)

    data = {
        "userID": user_id, # 使用從請求資料中獲取或生成的 user_id
        "doNotDisturbEnabled": dnd_status,
        "durationHours": dnd_duration_hours,
        "lastUpdated": datetime.datetime.now(),
    }

    try:
        db = get_db()
        # 使用從請求資料中獲取或生成的 user_id 作為文件 ID
        db.collection("userSettings").document(user_id).set(data)
        print(f"成功為使用者 {user_id} 更新 DND 設定。")
        return {"message": "DND 設定已成功儲存到 Firestore！", "status": "success"}
    except Exception as e:
        print(f"寫入 Firestore 時發生錯誤: {e}")
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.INTERNAL,
            message=f"無法儲存 DND 設定: {e}"
        )

# @https_fn.on_call(enforce_app_check=True) # getUserSettings 也應遵循相同的邏輯
# def getUserSettings(req: https_fn.CallableRequest):
#     print("Python Cloud Function 'getUserSettings' was called.")
#     user_id = req.data.get("userId") 
#     if not user_id:
#         raise https_fn.HttpsError(
#             code=https_fn.FunctionsErrorCode.INVALID_ARGUMENT,
#             message="未提供使用者ID，無法讀取設定。客戶端必須在請求資料中提供 'userId'。"
#         )
#     # ... (其餘讀取邏輯) ...
