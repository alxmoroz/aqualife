// Copyright (c) 2021. Alexandr Moroz

import 'package:aqualife/generated/l10n.dart';
import 'package:aqualife/models/app_settings.dart';
import 'package:aqualife/services/hive_storage.dart';
import 'package:aqualife/state/liquids_state.dart';
import 'package:aqualife/state/records_state.dart';
import 'package:package_info_plus/package_info_plus.dart';

late AppSettings settings;
late LiquidsState liquidsState;
late RecordsState recordsState;
late PackageInfo packageInfo;

S get loc => S.current;

//TODO: UI-constants
// bool get isTablet => iosInfo.model == 'iPad';
bool get isTablet => false;

// double get cardPadding => isTablet ? 20 : 10;
double get sidePadding => 12;

class Globals {
  static Future<void> initialize() async {
    await HiveStorage.init();

    // первый запуск приложения
    final firstLaunch = HiveStorage.appSettingsBox.values.isEmpty;
    if (firstLaunch) {
      await HiveStorage.appSettingsBox.add(AppSettings());
    }

    // стейты для типов жидкостей и записей
    liquidsState = LiquidsState();
    recordsState = RecordsState();
    liquidsState.loadLiquids();
    recordsState.loadRecords();

    //TODO: настройки вынести в стейт приложения
    settings = HiveStorage.appSettingsBox.values.first;

    packageInfo = await PackageInfo.fromPlatform();
    // final savedVersion = settings.version;
    final currentVersion = packageInfo.version;
    settings.version = currentVersion;
    // настройки
    await settings.save();
  }
}
