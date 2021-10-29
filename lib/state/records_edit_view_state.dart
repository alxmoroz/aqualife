// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../services/globals.dart';

part 'records_edit_view_state.g.dart';

class RecordsEditViewState = _RecordsEditViewStateBase with _$RecordsEditViewState;

abstract class _RecordsEditViewStateBase with Store {
  /// календарь
  @observable
  DateTime selectedDate = DateTime.now();

  @computed
  bool get canNextDate {
    final now = DateTime.now();
    return !(selectedDate.year == now.year && selectedDate.month == now.month && selectedDate.day == now.day);
  }

  @action
  void setNextDate() {
    selectedDate = selectedDate.add(const Duration(days: 1));
    _dateChanged();
  }

  @action
  void setPrevDate() {
    selectedDate = selectedDate.subtract(const Duration(days: 1));
    _dateChanged();
  }

  @action
  void setToday() {
    selectedDate = DateTime.now();
    _dateChanged();
  }

  /// редактирование количества жидкости
  TextEditingController? _controller;

  TextEditingController get controller {
    if (_controller == null) {
      _controller = TextEditingController(text: recordsState.waterQuantityForDate(selectedDate).toString());
      _controller!.addListener(_valueChanged);
    }
    return _controller!;
  }

  void _dateChanged() {
    controller.text = recordsState.waterQuantityForDate(selectedDate).toString();
  }

  @action
  void _valueChanged() {
    //TODO: валидация
    //TODO: пагинация по 50 мл
    //TODO: изменение записи за дату
    print(controller.text);
  }
}
