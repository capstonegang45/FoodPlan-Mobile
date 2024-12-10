import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Inisialisasi timezone
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  Future<void> showNotification(int id, String title, String body) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'meal_channel_id',
      'Meal Time Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
        id, title, body, notificationDetails);
  }

  Future<void> scheduleMealNotification(TimeOfDay timeOfDay) async {
    var scheduledTime = _nextInstanceOfTime(timeOfDay);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Waktunya Makan',
      'Saatnya menikmati makan!',
      scheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'meal_channel_id',
          'Meal Time Notifications',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      // Ensure proper scheduling parameters
      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
    );
  }

  tz.TZDateTime _nextInstanceOfTime(TimeOfDay timeOfDay) {
    final now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
        now.day, timeOfDay.hour, timeOfDay.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate
          .add(const Duration(days: 1)); // jika waktu sudah lewat, set ke besok
    }
    return scheduledDate;
  }
}
