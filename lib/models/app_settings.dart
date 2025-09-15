// Copyright (c) 2021. Alexandr Moroz

import 'package:hive/hive.dart';

import '../constants/app_constants.dart';
import '../services/hive_storage.dart';

part 'app_settings.g.dart';

@HiveType(typeId: HType.AppSettings)
class AppSettings extends HiveObject {
  @HiveField(0, defaultValue: '')
  String version = '';

  @HiveField(1, defaultValue: 'measure_unit_ml')
  String measureUnitCode = 'measure_unit_ml';

  @HiveField(2, defaultValue: 250)
  num lastShotValue = 250;

  @HiveField(3, defaultValue: AppConstants.defaultUserWeight)
  int userWeight = AppConstants.defaultUserWeight; // вес пользователя в кг для расчета дневной нормы
}
