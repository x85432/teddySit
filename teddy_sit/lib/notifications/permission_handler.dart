// lib/notification/permission_handler.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationPermissionHandler {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> requestNotificationPermissions() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      final status = await Permission.notification.request();

      switch (status) {
        case PermissionStatus.granted:
          debugPrint('Notification permissions granted');
          break;
        case PermissionStatus.denied:
          debugPrint('Notification permissions denied');
          break;
        case PermissionStatus.permanentlyDenied:
          debugPrint('Notification permissions permanently denied');
          break;
        default:
          break;
      }
    }
  }

  Future<bool> checkNotificationPermissions() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final result = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.checkPermissions();
      return result?.isEnabled ?? false;
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      return await Permission.notification.isGranted;
    }

    return false;
  }
}