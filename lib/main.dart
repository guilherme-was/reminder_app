import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'notification_service.dart';

// @pragma('vm:entry-point')
// void printHello() {
//   final DateTime now = DateTime.now();
//   final int isolateId = Isolate.current.hashCode;
//   print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  await NotificationService().initialize();
  runApp(const ReminderApp());
}

class ReminderApp extends StatelessWidget {
  const ReminderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
