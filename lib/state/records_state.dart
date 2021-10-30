// Copyright (c) 2021. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../models/record.dart';
import '../services/date_utils.dart';
import '../services/globals.dart';
import '../services/hive_storage.dart';

part 'records_state.g.dart';

class RecordsState = _RecordsStateBase with _$RecordsState;

abstract class _RecordsStateBase with Store {
  static const DEFAULT_LIQUID_CODE = 'water';

  @observable
  ObservableList<Record> records = ObservableList();

  @action
  void _setRecords(Iterable<Record> newRecords) => records
    ..clear()
    ..addAll(newRecords);

  @action
  Future<Record> _getOrCreateRecordForDate({required DateTime date, required String liquidCode}) async {
    final record = records.firstWhere(
      (r) => sameDay(date, r.dateTime) && r.liquid.code == liquidCode,
      orElse: () => Record(
        liquid: liquidsState.getOrCreateLiquidByCode(liquidCode),
        dateTime: date,
      ),
    );
    if (!record.isInBox) {
      records.add(record);
      await HiveStorage.recordBox.add(record);
    }

    return record;
  }

  @computed
  DateTime get firstDate => records.isNotEmpty ? records.first.dateTime : DateTime.now();

  Future<void> addQuantityForDate({required int quantity, required DateTime date, String? liquidCode}) async {
    final record = await _getOrCreateRecordForDate(date: date, liquidCode: liquidCode ?? DEFAULT_LIQUID_CODE);
    await setQuantityForRecord(record, record.liquidQuantity + quantity);
  }

  Future<void> subtractQuantityForDate({required int quantity, required DateTime date, String? liquidCode}) async {
    final record = await _getOrCreateRecordForDate(date: date, liquidCode: liquidCode ?? DEFAULT_LIQUID_CODE);
    await setQuantityForRecord(record, record.liquidQuantity - quantity);
  }

  Future<void> setQuantityForDate({required int quantity, required DateTime date, String? liquidCode}) async {
    final record = await _getOrCreateRecordForDate(date: date, liquidCode: liquidCode ?? DEFAULT_LIQUID_CODE);
    await setQuantityForRecord(record, quantity);
  }

  Future<void> setQuantityForRecord(Record record, int quantity) async {
    //валидация
    if (quantity < 0) {
      quantity = 0;
    }
    if (quantity > 9999) {
      quantity = 9999;
    }

    record.liquidQuantity = quantity;
    await record.save();

    loadRecords();
  }

  void loadRecords() {
    _setRecords(HiveStorage.recordBox.values);
  }

  // все типы жидкостей за дату
  List<Record> _recordsForDate(DateTime date) => records.where((r) => sameDay(date, r.dateTime)).toList(growable: false);

  // именно вода, расчётное количество из всех жидкостей за дату
  int waterQuantityForDate(DateTime date) => _recordsForDate(date).fold(0, (sum, r) => sum + r.waterQuantity);

  // именно вода за сегодня
  int get waterQuantityToday => waterQuantityForDate(DateTime.now());

  //TODO: расчёт ежедневной нормы
  int get dayQuota => 2000;
}
