// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../constants/app_constants.dart';
import '../../services/globals.dart';
import '../components/buttons.dart';
import '../components/icons.dart';
import '../components/text_widgets.dart';

class MonthSelector extends StatelessWidget {
  const MonthSelector({super.key});

  bool get _showTodayBtn {
    final today = DateTime.now();
    return !(statsState.selectedMonth.year == today.year && statsState.selectedMonth.month == today.month);
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
              child: Button.icon(chevronFastForwardIcon(context), statsState.setCurrentMonth,
                  padding: const EdgeInsets.only(right: AppConstants.sidePadding * 2)),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              statsState.canPrevMonth ? Button.icon(chevronBackIcon(context), statsState.setPrevMonth) : emptyButton,
              H3(DateFormat.yMMMM().format(statsState.selectedMonth)),
              statsState.canNextMonth ? Button.icon(chevronForwardIcon(context), statsState.setNextMonth) : emptyButton,
            ],
          ),
        ],
      ),
    );
  }
}
