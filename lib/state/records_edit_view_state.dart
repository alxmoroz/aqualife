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
    _updateControllerText();
  }

  @action
  void setPrevDate() {
    selectedDate = selectedDate.subtract(const Duration(days: 1));
    _updateControllerText();
  }

  @action
  void setToday() {
    selectedDate = DateTime.now();
    _updateControllerText();
  }

  /// редактирование количества жидкости
  TextEditingController? _controller;

  TextEditingController get controller {
    if (_controller == null) {
      _controller = TextEditingController(text: recordsState.waterQuantityForDate(selectedDate).toString());
      _controller!.addListener(_textFieldValueChanged);
    }
    return _controller!;
  }

  void _updateControllerText() {
    controller.text = recordsState.waterQuantityForDate(selectedDate).toString();
    controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
  }

  Future<void> _textFieldValueChanged() async {
    if (controller.text.startsWith('0')) {
      controller.text = controller.text.replaceFirst(RegExp(r'0*'), '');
      controller.selection = TextSelection.fromPosition(const TextPosition(offset: 0));
    }
    await recordsState.setQuantityForDate(quantity: int.tryParse(controller.text) ?? 0, date: selectedDate);
  }

  Future<void> plusButtonPressed() async {
    await recordsState.addQuantityForDate(quantity: 50, date: selectedDate);
    _updateControllerText();
  }

  Future<void> minusButtonPressed() async {
    await recordsState.subtractQuantityForDate(quantity: 50, date: selectedDate);
    _updateControllerText();
  }
}
