// Copyright (c) 2021. Alexandr Moroz

import 'package:aqualife/services/hive_storage.dart';
import 'package:hive/hive.dart';

part 'app_settings.g.dart';

@HiveType(typeId: HType.AppSettings)
class AppSettings extends HiveObject {
  @HiveField(0, defaultValue: '')
  String version = '';
}
