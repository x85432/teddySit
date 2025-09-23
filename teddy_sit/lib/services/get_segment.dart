import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SegmentDataService {

  static Future<List<Map<String, dynamic>>> getSegmentsByDate(String date) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final email = user?.email;

      debugPrint('🔍 用戶登錄狀態: ${user != null ? "已登錄" : "未登錄"}');
      debugPrint('🔍 用戶 email: $email');
      debugPrint('🔍 原始查詢日期: $date');

      // 將日期格式化為 yyyy-MM-dd
      String formattedDate;
      try {
        final dateTime = DateTime.parse(date);
        formattedDate = '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
        debugPrint('🔍 格式化後的日期: $formattedDate');
      } catch (e) {
        debugPrint('❌ 日期格式化失敗，使用原始日期: $e');
        formattedDate = date;
      }

      if (email == null) {
        debugPrint('❌ 用戶未登錄');
        return [];
      }

      debugPrint('🔍 查詢路徑: users anaylsis/$email');
      final docSnapshot = await FirebaseFirestore.instance
          .collection("users anaylsis")
          .doc(email)
          .get();

      debugPrint('🔍 文檔是否存在: ${docSnapshot.exists}');
      if (!docSnapshot.exists) {
        debugPrint('❌ 用戶文檔不存在');
        return [];
      }

      final data = docSnapshot.data();
      debugPrint('🔍 文檔數據是否為空: ${data == null}');
      debugPrint('🔍 文檔數據 keys: ${data?.keys}');

      final dateData = data?['dateData'] as Map<String, dynamic>? ?? {};
      debugPrint('🔍 dateData 是否為空: ${dateData.isEmpty}');
      debugPrint('🔍 dateData 有的日期: ${dateData.keys}');

      final dayData = dateData[formattedDate] as Map<String, dynamic>? ?? {};
      debugPrint('🔍 指定日期 $formattedDate 的數據是否為空: ${dayData.isEmpty}');
      debugPrint('🔍 該日期的 session keys: ${dayData.keys}');

      List<Map<String, dynamic>> allSegments = [];

      for (var sessionId in dayData.keys) {
        debugPrint('🔍 處理 session: $sessionId');
        final sessionData = dayData[sessionId] as Map<String, dynamic>? ?? {};
        debugPrint('🔍 sessionData keys: ${sessionData.keys}');

        final sensorData = sessionData['sensorData'];
        debugPrint('🔍 sensorData 的類型: ${sensorData.runtimeType}');

        if (sensorData is List) {
          debugPrint('🔍 sensorData 是 List，長度: ${sensorData.length}');

          // 處理每個 segment
          for (int segmentIndex = 0; segmentIndex < sensorData.length; segmentIndex++) {
            final segment = sensorData[segmentIndex] as Map<String, dynamic>? ?? {};
            debugPrint('🔍 處理 segment $segmentIndex，keys: ${segment.keys}');

            // 提取 startTime 和 endTime
            final startTime = segment['startTime'] ?? '';
            final endTime = segment['endTime'] ?? '';

            // 提取所有數字 key 作為 frames
            List<Map<String, dynamic>> frames = [];
            for (var key in segment.keys) {
              if (key != 'startTime' && key != 'endTime') {
                // 數字 key 對應的是 frame 數據
                final frameData = segment[key] as Map<String, dynamic>? ?? {};
                frames.add(frameData);
              }
            }

            debugPrint('🔍 Segment $segmentIndex: ${frames.length} frames, $startTime - $endTime');

            if (frames.isNotEmpty) {
              final processedSegment = {
                'sessionId': sessionId,
                'startTime': startTime,
                'endTime': endTime,
                'frames': frames,
              };

              allSegments.add(processedSegment);
            }
          }
        } else {
          debugPrint('🔍 sensorData 不是 List，無法處理');
        }
      }

      allSegments.sort((a, b) {
        try {
          final timeA = DateTime.parse(a['startTime']);
          final timeB = DateTime.parse(b['startTime']);
          return timeA.compareTo(timeB);
        } catch (e) {
          return 0;
        }
      });

      return allSegments;

    } catch (e) {
      return [];
    }
  }

  static Map<String, double> getSegmentStartEndScores(Map<String, dynamic> segment) {
    final frames = segment['frames'] as List? ?? [];

    if (frames.isEmpty) {
      return {'startScore': 0.0, 'endScore': 0.0};
    }

    final firstFrame = frames.first as Map<String, dynamic>? ?? {};
    final lastFrame = frames.last as Map<String, dynamic>? ?? {};

    final startScore = firstFrame['frame_score']?.toDouble() ?? 0.0;
    final endScore = lastFrame['frame_score']?.toDouble() ?? 0.0;

    return {
      'startScore': startScore,
      'endScore': endScore,
    };
  }
	
  static double getSegmentDuration(Map<String, dynamic> segment) {
    try {
      final startTime = DateTime.parse(segment['startTime']);
      final endTime = DateTime.parse(segment['endTime']);
      return endTime.difference(startTime).inSeconds.toDouble();
    } catch (e) {
      return 0.0;
    }
  }
}