// Copyright (c) 2021. Alexandr Moroz

import 'package:hive/hive.dart';

import '../services/hive_storage.dart';
import 'liquid.dart';

part 'record.g.dart';

@HiveType(typeId: HType.Record)
class Record extends HiveObject {
  Record({required this.dateTime, Liquid? liquid}) {
    _liquidHL = HiveList(HiveStorage.liquidBox);
    if (liquid != null) {
      _liquidHL!.add(liquid);
    }
  }

  @HiveField(0)
  DateTime dateTime = DateTime.now();

  @HiveField(1, defaultValue: 0)
  int liquidQuantity = 0;

  @HiveField(2)
  HiveList<Liquid>? _liquidHL;

  Liquid get liquid => _liquidHL!.first;

  int get waterQuantity => (liquid.waterPart * liquidQuantity).round();
}
