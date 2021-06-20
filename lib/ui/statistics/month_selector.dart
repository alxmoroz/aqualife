// Copyright (c) 2021. Alexandr Moroz

import 'package:aqualife/services/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../components/buttons.dart';
import '../components/icons.dart';
import '../components/text/text_widgets.dart';

class MonthSelector extends StatelessWidget {
  bool get _showTodayBtn => recordsState.canPrevMonth || recordsState.canNextMonth;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          recordsState.canPrevMonth ? Button.icon(chevronBackIcon(context), recordsState.setPrevMonth) : const SizedBox(width: 44),
          MediumText(DateFormat.yMMMM().format(recordsState.selectedMonth)),
          recordsState.canNextMonth ? Button.icon(chevronForwardIcon(context), recordsState.setNextMonth) : const SizedBox(width: 44),
          const Spacer(),
          if (_showTodayBtn) Button(loc.today, recordsState.setCurrentMonth, padding: EdgeInsets.only(right: sidePadding)),
        ],
          ),
    );
  }
}
