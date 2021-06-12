// Copyright (c) 2021. Alexandr Moroz

import 'package:aqualife/generated/l10n.dart';
import 'package:aqualife/models/app_settings.dart';
import 'package:aqualife/services/hive_storage.dart';
import 'package:package_info/package_info.dart';

late AppSettings settings;

S get loc => S.current;

//TODO: UI-constants
// bool get isTablet => iosInfo.model == 'iPad';
bool get isTablet => false;

// double get cardPadding => isTablet ? 20 : 10;
double get cardPadding => 10;

class Globals {
  static Future<void> initialize() async {
    await HiveStorage.init();

    // первый запуск приложения
    final firstLaunch = HiveStorage.appSettingsBox.values.isEmpty;
    if (firstLaunch) {
      await HiveStorage.appSettingsBox.add(AppSettings());
    }

    settings = HiveStorage.appSettingsBox.values.first;

    final packageInfo = await PackageInfo.fromPlatform();
    // final savedVersion = settings.version;
    final currentVersion = packageInfo.version;
    settings.version = currentVersion;

    // настройки
    await settings.save();
  }
}
