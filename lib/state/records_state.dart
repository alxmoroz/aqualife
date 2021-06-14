import 'package:aqualife/models/record.dart';
import 'package:aqualife/services/globals.dart';
import 'package:aqualife/services/hive_storage.dart';
import 'package:mobx/mobx.dart';

part 'records_state.g.dart';

class RecordsState = _RecordsStateBase with _$RecordsState;

abstract class _RecordsStateBase with Store {
  @observable
  List<Record> records = [];

  @action
  void _setRecords(List<Record> newRecords) => records = newRecords;

  Future<void> addRecord({required int quantity, String? liquidCode}) async {
    final record = Record(liquidQuantity: quantity, liquid: liquidsState.getOrCreateLiquidByCode(liquidCode ?? 'water'));
    await HiveStorage.recordBox.add(record);
    loadRecords();
  }

  void loadRecords() {
    _setRecords(HiveStorage.recordBox.values.toList(growable: false));
  }

  bool _sameDay(DateTime date1, DateTime date2) => date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;

  List<Record> recordsForDate(DateTime date) => records.where((r) => _sameDay(date, r.dateTime)).toList(growable: false);

  @computed
  int get todayWaterQuantity => recordsForDate(DateTime.now()).fold(0, (sum, r) => sum + r.waterQuantity);

  int get dayQuota => 2000;
}
