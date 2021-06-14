import 'package:aqualife/models/liquid.dart';
import 'package:aqualife/services/hive_storage.dart';
import 'package:hive/hive.dart';

part 'record.g.dart';

@HiveType(typeId: HType.Record)
class Record extends HiveObject {
  Record({Liquid? liquid, required this.liquidQuantity}) {
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
