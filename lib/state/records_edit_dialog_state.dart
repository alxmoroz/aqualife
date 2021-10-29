// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../services/globals.dart';

part 'records_edit_dialog_state.g.dart';

//TODO: стейт не только для диалога
class RecordsEditDialogState = _RecordsEditDialogStateBase with _$RecordsEditDialogState;

abstract class _RecordsEditDialogStateBase with Store {
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
    updateControllerText();
  }

  @action
  void setPrevDate() {
    selectedDate = selectedDate.subtract(const Duration(days: 1));
    updateControllerText();
  }

  @action
  void setToday() {
    selectedDate = DateTime.now();
    updateControllerText();
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

  void updateControllerText() {
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
