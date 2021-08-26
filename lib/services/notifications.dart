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
  late FlutterLocalNotificationsPlugin lnPlugin;

  Future init() async {
    lnPlugin = FlutterLocalNotificationsPlugin();
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

    // test
    // await lnPlugin.show(2, 'title 2 F', 'body 2 F', null);
    // print(tz.TZDateTime.local(2021, 1, 1, 9, 0));
  }

  Future scheduleNotifications() async {
    const lnDetails = NotificationDetails(iOS: IOSNotificationDetails(threadIdentifier: 'aqualife'));

    final notifications = [
      NotificationData(tz.TZDateTime.local(2021, 1, 1, 9), loc.notification_wakeup_title),
      NotificationData(tz.TZDateTime.local(2021, 1, 1, 11), loc.notification_day_title),
      NotificationData(tz.TZDateTime.local(2021, 1, 1, 13), loc.notification_day_title),
      NotificationData(tz.TZDateTime.local(2021, 1, 1, 15), loc.notification_day_title),
      NotificationData(tz.TZDateTime.local(2021, 1, 1, 17), loc.notification_day_title),
      NotificationData(tz.TZDateTime.local(2021, 1, 1, 19), loc.notification_day_title),
      NotificationData(tz.TZDateTime.local(2021, 1, 1, 21), loc.notification_day_title),
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
  }

  Future rescheduleNotifications() async {
    await cancelNotifications();
    await scheduleNotifications();
  }

  Future cancelNotifications() async {
    await lnPlugin.cancelAll();
  }
}
