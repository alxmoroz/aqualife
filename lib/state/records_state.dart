// Copyright (c) 2021. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../models/record.dart';
import '../services/globals.dart';
import '../services/hive_storage.dart';

part 'records_state.g.dart';

class RecordsState = _RecordsStateBase with _$RecordsState;

abstract class _RecordsStateBase with Store {
  @observable
  List<Record> records = [];

  @action
  void _setRecords(List<Record> newRecords) => records = newRecords;

  @computed
  DateTime get firstDate => records.isNotEmpty ? records.first.dateTime : DateTime.now();

  bool _sameDay(DateTime date1, DateTime date2) => date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;

  Future<void> addRecord({required int quantity, String? liquidCode}) async {
    final record = HiveStorage.recordBox.values.firstWhere(
      (r) => _sameDay(DateTime.now(), r.dateTime) && r.liquid.code == liquidCode,
      orElse: () => Record(
        liquidQuantity: quantity,
        liquid: liquidsState.getOrCreateLiquidByCode(liquidCode ?? 'water'),
      ),
    );
    if (record.isInBox) {
      record.liquidQuantity += quantity;
      await record.save();
    } else {
      await HiveStorage.recordBox.add(record);
    }

    // settings.lastShotValue = quantity;
    // await settings.save();

    loadRecords();
  }

  void loadRecords() {
    _setRecords(HiveStorage.recordBox.values.toList(growable: false));
  }

  List<Record> _recordsForDate(DateTime date) => records.where((r) => _sameDay(date, r.dateTime)).toList(growable: false);

  int waterQuantityForDate(DateTime date) => _recordsForDate(date).fold(0, (sum, r) => sum + r.waterQuantity);

  int get waterQuantityToday => waterQuantityForDate(DateTime.now());

  //TODO: расчёт ежедневной нормы
  int get dayQuota => 2000;
}
