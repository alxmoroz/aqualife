// Copyright (c) 2021. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../services/globals.dart';

part 'stats_state.g.dart';

class StatsState = _StatsStateBase with _$StatsState;

abstract class _StatsStateBase with Store {
  @observable
  DateTime selectedMonth = DateTime.now();

  @action
  void setNextMonth() {
    selectedMonth = DateTime(selectedMonth.year, selectedMonth.month + 1);
  }

  @action
  void setPrevMonth() {
    selectedMonth = DateTime(selectedMonth.year, selectedMonth.month - 1);
  }

  @action
  void setCurrentMonth() {
    selectedMonth = DateTime.now();
  }

  @computed
  bool get canNextMonth {
    final now = DateTime.now();
    return !(selectedMonth.year == now.year && selectedMonth.month == now.month);
  }

  @computed
  bool get canPrevMonth {
    return !(selectedMonth.year == recordsState.firstDate.year && selectedMonth.month == recordsState.firstDate.month);
  }
}
