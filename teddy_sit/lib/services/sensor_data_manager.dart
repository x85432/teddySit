import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// 感測器資料管理類別
class SensorDataManager {
  // 改為以日期為 key 的 Map 結構
  static Map<String, Map<String, dynamic>> _dateData = {};
  static const String _storageKey = 'sensor_date_data';

  // 初始化並載入資料
  static Future<void> initialize() async {
    // 清掉舊的資料格式（一次性操作）
    await clearOldData();

    await loadData();
    debugPrint('📱 SensorDataManager 初始化完成');
  }

  // 清掉舊的 SharedPreferences 資料（舊的 key）
  static Future<void> clearOldData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // 清掉可能的舊 keys
      await prefs.remove('sensor_sessions_data');
      await prefs.remove('sensor_data');

      // 也清掉新的 key（完全重新開始）
      await prefs.remove(_storageKey);

      debugPrint('🗑️ 已清理所有 SharedPreferences 資料（包含新舊格式）');
    } catch (e) {
      debugPrint('❌ 清理舊資料失敗: $e');
    }
  }

  // 儲存資料到 SharedPreferences
  static Future<void> saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(_dateData);
      await prefs.setString(_storageKey, jsonString);
      final user = FirebaseAuth.instance.currentUser;
      final email = user?.email;

      final firestore = FirebaseFirestore.instance;

      await firestore
      .collection("users anaylsis")          // 🔹 第一層: 使用者集合
      .doc(email)              // 🔹 單一使用者文件 (用 email 當 key)
      .set({
        "dateData": _dateData,     // 🔹 存你的資料
        "updatedAt": FieldValue.serverTimestamp()
      }, SetOptions(merge: true)); // merge 避免覆蓋其他欄位

      int totalSessions = 0;
      _dateData.forEach((date, dateInfo) {
        totalSessions += dateInfo.length; // 每個 key 就是一個 session
      });

      debugPrint('📱 成功儲存資料到 SharedPreferences (${_dateData.length} 個日期, $totalSessions 個 sessions)');
    } catch (e) {
      debugPrint('❌ 儲存資料失敗: $e');
    }
  }

  // 從 SharedPreferences 載入資料
  static Future<void> loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // 顯示存儲位置資訊
      debugPrint('📱 SharedPreferences 存儲位置:');
      debugPrint('📱 Android: /data/data/com.example.teddy_sit/shared_prefs/FlutterSharedPreferences.xml');
      debugPrint('📱 實際 key: flutter.$_storageKey');

      final jsonString = prefs.getString(_storageKey);

      if (jsonString != null && jsonString.isNotEmpty) {
        debugPrint('📱 找到資料，大小: ${jsonString.length} 字元');
        debugPrint('📱 資料內容前 200 字元: ${jsonString.substring(0, jsonString.length > 200 ? 200 : jsonString.length)}...');

        final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        _dateData = jsonMap.map((key, value) => MapEntry(key, Map<String, dynamic>.from(value)));

        int totalSessions = 0;
        _dateData.forEach((date, dateInfo) {
          totalSessions += dateInfo.length; // 每個 key 就是一個 session
        });

        debugPrint('📱 成功載入資料，共 ${_dateData.length} 個日期, $totalSessions 個 sessions');
      } else {
        _dateData = {};
        debugPrint('📱 沒有找到現有資料，初始化空 Map');
      }
    } catch (e) {
      debugPrint('❌ 載入資料失敗: $e');
      _dateData = {};
    }
  }

  // 新增感測器資料（自動存儲到 SharedPreferences）
  static Future<void> addSensorData(List<Map<String, dynamic>> newData, String startTime, String endTime) async {
    final sessionId = DateTime.now().millisecondsSinceEpoch.toString();
    // 從 startTime 提取日期部分
    final date = DateTime.parse(startTime).toString().split(' ')[0];

    // 如果該日期不存在，創建新的日期條目
    if (!_dateData.containsKey(date)) {
      _dateData[date] = {};
    }

    // 創建新的 session 資料（不包含 sessionId，因為 sessionId 是 key）
    final sessionData = [
      {
        'startTime': startTime,
        'endTime': endTime,
        'dataCount': newData.length,
        'sensorData': newData,
      }
    ];

    // 以 sessionId 作為 key 存儲到對應日期中
    _dateData[date]![sessionId] = sessionData;

    // 自動存儲到 SharedPreferences
    await saveData();

    debugPrint('✅ 已儲存 Session $sessionId: ${newData.length} 筆感測器資料到日期 $date');

    int totalSessions = 0;
    _dateData.forEach((date, dateInfo) {
      totalSessions += dateInfo.length; // 每個 key 就是一個 session
    });
    debugPrint('📊 總共有 ${_dateData.length} 個日期, $totalSessions 個 sessions');
  }

  // 按日期查詢資料
  static Map<String, dynamic>? getDataByDate(String date) {
    return _dateData[date];
  }

  // 取得特定日期內所有的 sensorData（合併所有 sessions）
  static List<Map<String, dynamic>> getAllSensorDataByDate(String date) {
    List<Map<String, dynamic>> allSensorData = [];

    final dateInfo = _dateData[date];
    if (dateInfo != null) {
      dateInfo.forEach((sessionId, sessionDataList) {
        final sessionData = (sessionDataList as List).first;
        final sensorData = sessionData['sensorData'] as List? ?? [];
        allSensorData.addAll(List<Map<String, dynamic>>.from(sensorData));
      });
    }

    debugPrint('日期 $date 的所有 sensorData: ${allSensorData.length} 筆');
    return allSensorData;
  }

  // 取得特定日期的所有 sessions
  static List<Map<String, dynamic>> getSessionsByDate(String date) {
    final dateInfo = _dateData[date];
    if (dateInfo != null) {
      List<Map<String, dynamic>> sessions = [];
      dateInfo.forEach((sessionId, sessionDataList) {
        final sessionData = (sessionDataList as List).first;
        sessions.add({
          'sessionId': sessionId,
          'startTime': sessionData['startTime'],
          'endTime': sessionData['endTime'],
          'dataCount': sessionData['dataCount'],
          'sensorData': sessionData['sensorData'],
        });
      });
      return sessions;
    }
    return [];
  }

  // 取得所有感測器資料 (所有session合併)
  static List<Map<String, dynamic>> getAllSensorData() {
    List<Map<String, dynamic>> allData = [];
    _dateData.forEach((date, dateInfo) {
      dateInfo.forEach((sessionId, sessionDataList) {
        final sessionData = (sessionDataList as List).first;
        final sensorData = sessionData['sensorData'] as List? ?? [];
        allData.addAll(List<Map<String, dynamic>>.from(sensorData));
      });
    });
    return allData;
  }

  // 取得所有 sessions 列表
  static List<Map<String, dynamic>> getAllSessions() {
    List<Map<String, dynamic>> allSessions = [];

    _dateData.forEach((date, dateInfo) {
      dateInfo.forEach((sessionId, sessionDataList) {
        final sessionData = (sessionDataList as List).first;
        allSessions.add({
          'sessionId': sessionId,
          'startTime': sessionData['startTime'],
          'endTime': sessionData['endTime'],
          'dataCount': sessionData['dataCount'],
          'date': date,
        });
      });
    });

    return allSessions;
  }

  // 清空所有資料（包含 SharedPreferences）
  static Future<void> clearAllData() async {
    _dateData.clear();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_storageKey);
      debugPrint('🗑️ 已清空 SharedPreferences 資料');
    } catch (e) {
      debugPrint('❌ 清空資料失敗: $e');
    }

    debugPrint('🗑️ 已清空所有資料');
  }

  // 取得特定日期的所有 frame_score
  static List<double> getFrameScoresByDate(String date) {
    List<double> frameScores = [];

    final sessions = getSessionsByDate(date);
    for (var session in sessions) {
      final sensorData = session['sensorData'] as List? ?? [];
      for (var data in sensorData) {
        double frameScore = data['frame_score']?.toDouble() ?? 0.0;
        frameScores.add(frameScore);
      }
    }

    debugPrint('日期 $date 找到 ${frameScores.length} 筆 frame_score');
    return frameScores;
  }

  // 取得特定日期的所有 frame_level
  static List<String> getFrameLevelsByDate(String date) {
    List<String> frameLevels = [];

    final sessions = getSessionsByDate(date);
    for (var session in sessions) {
      final sensorData = session['sensorData'] as List? ?? [];
      for (var data in sensorData) {
        String frameLevel = data['frame_level'] ?? 'Unknown';
        frameLevels.add(frameLevel);
      }
    }

    debugPrint('日期 $date 找到 ${frameLevels.length} 筆 frame_level');
    return frameLevels;
  }

  // 計算特定日期的平均 frame_score
  static double getAverageFrameScoreByDate(String date) {
    final frameScores = getFrameScoresByDate(date);

    if (frameScores.isEmpty) {
      debugPrint('日期 $date 沒有 frame_score 資料');
      return 0.0;
    }

    double total = frameScores.reduce((a, b) => a + b);
    double average = (total / frameScores.length).roundToDouble();

    debugPrint('日期 $date 的平均 frame_score: ${average.toStringAsFixed(0)} (共 ${frameScores.length} 筆資料)');
    return average;
  }

  // 使用 getAllSensorDataByDate 直接計算平均 frame_score
  static double getAverageFrameScoreByDateDirect(List<Map<String, dynamic>> datas) {

    List<double> frameScores = [];
    for (var data in datas) {
      double frameScore = data['frame_score']?.toDouble() ?? 0.0;
      frameScores.add(frameScore);
    }

    if (frameScores.isEmpty) {
      return 0.0;
    }

    double total = frameScores.reduce((a, b) => a + b);
    double average = (total / frameScores.length).roundToDouble();

    return average;
  }

  // 統計特定日期所有 frame_level 的分佈
  static Map<String, double> getFrameLevelStatsByDate(List<Map<String, dynamic>> datas) {

    Map<String, double> frameLevelStats = {};

    for (var data in datas) {
      String frameLevel = data['frame_level']?.toString() ?? 'Unknown';
      frameLevelStats[frameLevel] = (frameLevelStats[frameLevel] ?? 0) + 1;
    }

    return frameLevelStats;
  }

  // 取得從現在開始到30秒前的感測器資料
  static List<Map<String, dynamic>> getSensorDataLast30Seconds(int num) {
    // final now = DateTime.parse("2025-09-20 19:54:00+08:00"); // For testing purpose
    
    final now = DateTime.now().toUtc(); // 台灣時間 UTC+8
    debugPrint('現在時間 (UTC+8): $now');
    final thirtySecondsAgo = now.subtract(Duration(seconds: num));
    int ten = 10;
    List<Map<String, dynamic>> recentData = [];

    // 遍歷所有日期的所有sessions
    _dateData.forEach((date, dateInfo) {
      dateInfo.forEach((sessionId, sessionDataList) {
        final sessionData = (sessionDataList as List).first;
        final sensorData = sessionData['sensorData'] as List? ?? [];

        // 檢查每筆sensor data的時間戳
        for (var data in sensorData) {
          if (data['timestamp'] != null) {
            try {
              final dataTime = DateTime.parse(data['timestamp']);
              // 如果資料時間在30秒內，加入結果
              if (dataTime.isAfter(thirtySecondsAgo) && dataTime.isBefore(thirtySecondsAgo.add(Duration(seconds: ten)))) {
                recentData.add(Map<String, dynamic>.from(data));
              }
            } catch (e) {
              debugPrint('解析時間戳失敗: ${data['timestamp']}, 錯誤: $e');
            }
          }
        }
      });
    });

    // 按時間排序（最新的在前面）
    recentData.sort((a, b) {
      try {
        final timeA = DateTime.parse(a['timestamp']);
        final timeB = DateTime.parse(b['timestamp']);
        return timeB.compareTo(timeA);
      } catch (e) {
        return 0;
      }
    });

    debugPrint('取得最近10秒的感測器資料: ${recentData.length} 筆');
    return recentData;
  }

}