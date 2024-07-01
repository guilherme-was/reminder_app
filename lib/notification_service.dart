import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidNotificationChannel callChannel = AndroidNotificationChannel(
      'call_channel_waza', // channel ID
      'Call Notifications', // channel name
      description: 'Incoming call notifications',
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(callChannel);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(String title) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('call_channel_waza', 'Call Notifications',
            importance: Importance.max, priority: Priority.high, showWhen: false);

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.show(
        0, title, 'É hora do seu lembrete!', platformChannelSpecifics);
  }
}
