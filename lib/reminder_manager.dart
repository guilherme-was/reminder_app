import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class ReminderManager {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  ReminderManager() {
    initializeTimezone();
    initializeNotifications();
  }

  void initializeTimezone() {
    tzdata.initializeTimeZones();
  }

  void initializeNotifications() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleReminder(String title, int timeInSeconds,
      {String? description}) async {
    final location =
        tz.getLocation('America/Sao_Paulo'); // Ajuste para seu fuso horário
    tz.TZDateTime scheduledDate =
        tz.TZDateTime.now(location).add(Duration(seconds: timeInSeconds));

    await flutterLocalNotificationsPlugin.zonedSchedule(
      title.hashCode, // ID da notificação
      title, // Título da notificação
      description ?? 'Este é o conteúdo da notificação', // Corpo da notificação
      scheduledDate, // Horário agendado
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'call_channel_waza',
          'Call Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
