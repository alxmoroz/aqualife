// Copyright (c) 2021. Alexandr Moroz

import 'package:hive/hive.dart';

import '../services/hive_storage.dart';

part 'liquid.g.dart';

@HiveType(typeId: HType.Liquid)
class Liquid extends HiveObject {
  Liquid({this.code = '', this.waterPart = 1.0, this.composition = ''});

  @HiveField(0, defaultValue: '')
  String code;

  @HiveField(1, defaultValue: '')
  String composition;

  @HiveField(2, defaultValue: 1.0)
  double waterPart;
}
