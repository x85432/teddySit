// lib/notification/service.dart
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        debugPrint('Notification clicked: ${response.payload}');
      },
    );
  }

  /*Future<bool> _isAppInBackground() async {
    try {
      final state = WidgetsBinding.instance.lifecycleState;
      return state == AppLifecycleState.paused ||
          state == AppLifecycleState.detached ||
          state == AppLifecycleState.inactive;
    } catch (e) {
      return true;
    }
  }*/

  Future<void> showBasicNotification(String title, String body) async {
    //final bool isBackground = await _isAppInBackground();

    //if (isBackground) {
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        'basic_channel', // channel ID
        'Time stop', // channel name
        channelDescription: 'This notification shows when time stops',
        importance: Importance.high,
        priority: Priority.high,
        icon: 'enterbear',
        largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
        styleInformation: BigTextStyleInformation(''),
        color: Color(0xFF4CAF50),
      );

      const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const NotificationDetails platformDetails =
          NotificationDetails(android: androidDetails, iOS: iOSDetails);

      await flutterLocalNotificationsPlugin.show(
        0, // notification ID
        title,
        body,
        platformDetails,
        payload: 'notification.basic',
      );
    /*} else {
      debugPrint('App is in foreground, notification not shown');
    }*/
  }
}