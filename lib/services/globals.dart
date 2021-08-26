// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../generated/l10n.dart';
import '../models/app_settings.dart';
import '../services/hive_storage.dart';
import '../state/liquids_state.dart';
import '../state/records_state.dart';

late AppSettings settings;
late LiquidsState liquidsState;
late RecordsState recordsState;
late PackageInfo packageInfo;

S get loc => S.current;

// TODO: перенести взаимодействие с БД в стейты

// TODO: все глабальные штуки перенести в стейт приложения

//TODO: UI-constants
// bool get isTablet => iosInfo.model == 'iPad';
bool get isTablet => false;

// double get cardPadding => isTablet ? 20 : 10;
double get sidePadding => 12;

Future<void> initGlobals() async {
  await HiveStorage.init();

  if (HiveStorage.appSettingsBox.isEmpty) {
    await HiveStorage.appSettingsBox.add(AppSettings());
  }
  settings = HiveStorage.appSettingsBox.values.first;

  // типы жидкостей
  liquidsState = LiquidsState();
  liquidsState.loadLiquids();

  // записи
  recordsState = RecordsState();
  recordsState.loadRecords();

  // версия приложения
  packageInfo = await PackageInfo.fromPlatform();
  // final savedVersion = settings.version;
  final currentVersion = packageInfo.version;
  settings.version = currentVersion;
  await settings.save();

  // уведомления
  final lnPlugin = FlutterLocalNotificationsPlugin();
  await lnPlugin.initialize(const InitializationSettings(iOS: IOSInitializationSettings(requestBadgePermission: false)));
  await lnPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(alert: true, sound: true);
}
