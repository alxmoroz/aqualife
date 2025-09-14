// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../constants/app_constants.dart';
import 'globals.dart';

class NotificationData {
  const NotificationData(this.date, this.title, [this.body]);

  final String? title;
  final String? body;
  final tz.TZDateTime date;
}

class NotificationService {
  final lnPlugin = FlutterLocalNotificationsPlugin();
  final lnDetails = const NotificationDetails(iOS: DarwinNotificationDetails(threadIdentifier: AppConstants.notificationThreadId));

  Future init() async {
    await lnPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(requestBadgePermission: false),
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
    await lnPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(alert: true, sound: true);
    tz.initializeTimeZones();
    final timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  Future scheduleNotifications() async {
    final notifications = <NotificationData>[];
    
    // Утреннее уведомление
    notifications.add(NotificationData(
      tz.TZDateTime.local(2025, 1, 1, AppConstants.notificationHours.first, AppConstants.notificationMinutes),
      loc.notification_wakeup_title,
      loc.notification_wakeup_text,
    ));
    
    // Дневные уведомления
    for (int i = 1; i < AppConstants.notificationHours.length; i++) {
      notifications.add(NotificationData(
        tz.TZDateTime.local(2025, 1, 1, AppConstants.notificationHours[i], AppConstants.notificationMinutes),
        loc.notification_day_title,
        loc.notification_day_text,
      ));
    }

    for (final n in notifications) {
      await lnPlugin.zonedSchedule(
        n.date.hour,
        n.title,
        n.body,
        n.date,
        lnDetails,
        matchDateTimeComponents: DateTimeComponents.time,
        androidScheduleMode: AndroidScheduleMode.inexact,
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
