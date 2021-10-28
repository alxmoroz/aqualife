// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../services/globals.dart';
import '../components/buttons.dart';
import '../components/icons.dart';
import '../components/text/text_widgets.dart';

class MonthSelector extends StatelessWidget {
  bool get _showTodayBtn {
    final today = DateTime.now();
    return !(recordsState.selectedMonth.year == today.year && recordsState.selectedMonth.month == today.month);
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
                    child: Button(loc.today, recordsState.setCurrentMonth, padding: EdgeInsets.only(right: sidePadding * 2)),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    recordsState.canPrevMonth ? Button.icon(chevronBackIcon(context), recordsState.setPrevMonth) : emptyButton,
                    MediumText(DateFormat.yMMMM().format(recordsState.selectedMonth)),
                    recordsState.canNextMonth ? Button.icon(chevronForwardIcon(context), recordsState.setNextMonth) : emptyButton,
                  ],
                ),
              ],
            ));
  }
}
