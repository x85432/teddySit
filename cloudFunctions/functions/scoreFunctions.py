import math

def calculate_gravity(points):
    gravity = {'x':0, 'y':0}
    # sumOfScore = 0
    for p in points:
        gravity['x'] += p['x']
        gravity['y'] += p['y']
        # sumOfScore += p['score']

    gravity['x'] = gravity['x'] / len(points)
    gravity['y'] = gravity['y'] / len(points)

    return gravity

def calculate_cva(landmarks):
    """計算顱椎角 (CVA)"""
    try:
        # 關鍵點索引
        head_idxs          = [0]
        left_shoulder_idx  = 5
        right_shoulder_idx = 6

        # 檢查關鍵點是否存在
        if len(landmarks) <= max(left_shoulder_idx, right_shoulder_idx):
            return None, None
        head_points   = [landmarks[i] for i in head_idxs]
        head_gravity  = calculate_gravity(head_points)
        left_shoulder = landmarks[left_shoulder_idx]
        right_shoulder = landmarks[right_shoulder_idx]
        
        # min_score = 0.3
        # if ear['score'] < min_score or left_shoulder['score'] < min_score or right_shoulder['score'] < min_score:
        #     return None, "關鍵點可信度過低"

        shoulder_mid_x = (left_shoulder['x'] + right_shoulder['x']) / 2
        shoulder_mid_y = (left_shoulder['y'] + right_shoulder['y']) / 2
        
        vec_ear_shoulder_x = head_gravity['x'] - shoulder_mid_x
        vec_ear_shoulder_y = head_gravity['y'] - shoulder_mid_y
        vec_horizon_x = 1

        dot_product = (vec_ear_shoulder_x * vec_horizon_x)
        magnitude_A = math.sqrt(vec_ear_shoulder_x**2 + vec_ear_shoulder_y**2)
        
        if magnitude_A == 0:
            return None, "向量長度為零"
        
        cos_theta = dot_product / magnitude_A
        cos_theta = max(-1.0, min(1.0, cos_theta))
        angle_deg = math.degrees(math.acos(cos_theta))
        
        # 根據圖片標準給出等級
        if angle_deg >= 60:
            level = 3
        elif 50 <= angle_deg < 60:
            level = 2
        elif 40 <= angle_deg < 50:
            level = 1
        else:
            level = 0
        return angle_deg, level
        
    except Exception as e:
        print(f"CVA 計算錯誤: {e}")
        return None, None

def calculate_tia(landmarks):
    """計算軀幹傾斜角 (TIA)"""
    try:
        # 關鍵點索引
        left_shoulder_idx = 5
        right_shoulder_idx = 6
        left_hip_idx = 11
        right_hip_idx = 12

        # 檢查關鍵點是否存在
        
        if len(landmarks) <= max(left_shoulder_idx, right_shoulder_idx, left_hip_idx, right_hip_idx):
            return None, None
        
        if (landmarks[left_hip_idx]['score'] > landmarks[right_hip_idx]['score']): # 誰的屁股比較大
            shoulderChoice = 5
            hipChoice = 11
        else:
            shoulderChoice = 6
            hipChoice = 12
            
        
        # left_shoulder = landmarks[left_shoulder_idx]
        # right_shoulder = landmarks[right_shoulder_idx]
        # left_hip = landmarks[left_hip_idx]
        # right_hip = landmarks[right_hip_idx]

        # min_score = 0.5
        # if (left_shoulder['score'] < min_score or right_shoulder['score'] < min_score or
        #     left_hip['score'] < min_score or right_hip['score'] < min_score):
        #     return None, "關鍵點可信度過低"
        
        # shoulder_mid_x = (left_shoulder['x'] + right_shoulder['x']) / 2
        # shoulder_mid_y = (left_shoulder['y'] + right_shoulder['y']) / 2
        # hip_mid_x = (left_hip['x'] + right_hip['x']) / 2
        # hip_mid_y = (left_hip['y'] + right_hip['y']) / 2

        shoudler_x = landmarks[shoulderChoice]['x']
        shoulder_y = landmarks[shoulderChoice]['y']
        hip_x = landmarks[hipChoice]['x']
        hip_y = landmarks[hipChoice]['y']
        # 向量 A: 從髖部中間點到肩膀中間點
        vec_trunk_x = shoudler_x - hip_x
        vec_trunk_y = shoulder_y - hip_y

        # 向量 B: 垂直向上向量
        vec_vertical_x = 0
        vec_vertical_y = -1
        
        dot_product = (vec_trunk_x * vec_vertical_x) + (vec_trunk_y * vec_vertical_y)
        magnitude_A = math.sqrt(vec_trunk_x**2 + vec_trunk_y**2)
        
        if magnitude_A == 0:
            return None, "向量長度為零"
            
        cos_theta = dot_product / magnitude_A
        cos_theta = max(-1.0, min(1.0, cos_theta))
        angle_rad = math.acos(cos_theta)
        angle_deg = math.degrees(angle_rad)
        
        # 根據圖片標準給出等級
        if angle_deg <= 5:
            level = 3
        elif 5 < angle_deg <= 10:
            level = 2
        elif 10 <= angle_deg <= 15:
            level = 1
        else:
            level = 0
        return angle_deg, level
        
    except Exception as e:
        print(f"TIA 計算錯誤: {e}")
        return None, None