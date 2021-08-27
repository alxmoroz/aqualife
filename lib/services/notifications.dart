// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'globals.dart';

class NotificationData {
  const NotificationData(this.date, this.title, [this.body]);

  final String? title;
  final String? body;
  final tz.TZDateTime date;
}

class NotificationService {
  final lnPlugin = FlutterLocalNotificationsPlugin();
  final lnDetails = const NotificationDetails(iOS: IOSNotificationDetails(threadIdentifier: 'aqualife'));

  // TODO: убрать появление уведомлений при работе приложения
  Future init() async {
    await lnPlugin.initialize(
      const InitializationSettings(
        iOS: IOSInitializationSettings(
          requestBadgePermission: false,
          onDidReceiveLocalNotification: null,
        ),
      ),
    );
    await lnPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(alert: true, sound: true);
    tz.initializeTimeZones();
    final timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  Future scheduleNotifications() async {
    final notifications = [
      NotificationData(tz.TZDateTime.local(2021, 1, 1, 09), loc.notification_wakeup_title, loc.notification_wakeup_text),
      NotificationData(tz.TZDateTime.local(2021, 1, 1, 11), loc.notification_day_title, loc.notification_day_text),
      NotificationData(tz.TZDateTime.local(2021, 1, 1, 13), loc.notification_day_title, loc.notification_day_text),
      NotificationData(tz.TZDateTime.local(2021, 1, 1, 15), loc.notification_day_title, loc.notification_day_text),
      NotificationData(tz.TZDateTime.local(2021, 1, 1, 17), loc.notification_day_title, loc.notification_day_text),
      NotificationData(tz.TZDateTime.local(2021, 1, 1, 19), loc.notification_day_title, loc.notification_day_text),
      NotificationData(tz.TZDateTime.local(2021, 1, 1, 21), loc.notification_day_title, loc.notification_day_text),
    ];

    for (final n in notifications) {
      await lnPlugin.zonedSchedule(
        n.date.hour,
        n.title,
        n.body,
        n.date,
        lnDetails,
        matchDateTimeComponents: DateTimeComponents.time,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime,
      );
    }

    // test
    // await lnPlugin.show(1, loc.notification_wakeup_title, loc.notification_wakeup_text, lnDetails);
  }

  Future rescheduleNotifications() async {
    await cancelNotifications();
    await scheduleNotifications();
  }

  Future cancelNotifications() async {
    await lnPlugin.cancelAll();
  }
}
