// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../services/globals.dart';
import '../../state/records_edit_dialog_state.dart';
import '../components/buttons.dart';
import '../components/icons.dart';
import '../components/text/text_widgets.dart';

class DaySelector extends StatelessWidget {
  RecordsEditDialogState get _state => recordsEditDialogState;

  bool get _showTodayBtn {
    final today = DateTime.now();
    return !(_state.selectedDate.year == today.year && _state.selectedDate.month == today.month && _state.selectedDate.day == today.day);
  }

  @override
  Widget build(BuildContext context) {
    const emptyButton = Button('', null);
    return Observer(
      builder: (_) => Stack(
        children: [
          if (_showTodayBtn)
            Align(
              alignment: Alignment.centerRight,
              child: Button(loc.today, _state.setToday, padding: EdgeInsets.only(right: sidePadding * 2)),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Button.icon(chevronBackIcon(context), _state.setPrevDate),
              MediumText(DateFormat.yMMMMd().format(_state.selectedDate)),
              _state.canNextDate ? Button.icon(chevronForwardIcon(context), _state.setNextDate) : emptyButton,
            ],
          ),
        ],
      ),
    );
  }
}
