// Copyright (c) 2021. Alexandr Moroz

import 'package:package_info_plus/package_info_plus.dart';

import '../generated/l10n.dart';
import '../models/app_settings.dart';
import '../services/hive_storage.dart';
import '../services/notifications.dart';
import '../state/liquids_state.dart';
import '../state/records_edit_view_state.dart';
import '../state/records_state.dart';
import '../state/stats_state.dart';

/// Глобальные переменные состояния приложения
/// В будущем рекомендуется перенести в Provider/Riverpod для лучшей архитектуры
late AppSettings settings;
late LiquidsState liquidsState;
late RecordsState recordsState;
late RecordsEditViewState recordsEditViewState;
late StatsState statsState;

late NotificationService notificationService;
late PackageInfo packageInfo;

/// Локализация
S get loc => S.current;

/// UI константы
bool get isTablet => false; // TODO: реализовать определение планшета

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

  recordsEditViewState = RecordsEditViewState();
  statsState = StatsState();

  // версия приложения
  packageInfo = await PackageInfo.fromPlatform();
  // final savedVersion = settings.version;
  final currentVersion = packageInfo.version;
  settings.version = currentVersion;
  await settings.save();

  // уведомления
  notificationService = NotificationService();
  await notificationService.init();
  await notificationService.rescheduleNotifications();
}
