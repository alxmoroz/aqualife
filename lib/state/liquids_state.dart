// Copyright (c) 2021. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../models/liquid.dart';
import '../services/hive_storage.dart';

part 'liquids_state.g.dart';

class LiquidsState extends _LiquidsStateBase with _$LiquidsState {}

abstract class _LiquidsStateBase with Store {
  @observable
  List<Liquid> liquids = [];

  @action
  void _setLiquids(List<Liquid> newLiquids) => liquids = newLiquids;

  Future<void> addLiquid(Liquid liquid) async {
    await HiveStorage.liquidBox.add(liquid);
    loadLiquids();
  }

  void loadLiquids() {
    _setLiquids(HiveStorage.liquidBox.values.toList(growable: false));
  }

  Liquid getOrCreateLiquidByCode(String code) {
    return liquids.firstWhere((liquid) => liquid.code == code, orElse: () {
      final liquid = Liquid(code: code);
      addLiquid(liquid);
      return liquid;
    });
  }
}
