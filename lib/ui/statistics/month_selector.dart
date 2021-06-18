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
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          if (recordsState.canPrevMonth) Button.icon(chevronBack, recordsState.setPrevMonth),
          MediumText(DateFormat.yMMMM().format(recordsState.selectedMonth)),
          if (recordsState.canNextMonth) Button.icon(chevronForward, recordsState.setNextMonth),
          const Spacer(),
          Button(
            recordsState.canPrevMonth || recordsState.canNextMonth ? loc.today : '',
            recordsState.setCurrentMonth,
            padding: EdgeInsets.only(right: cardPadding),
          ),
        ],
      ),
    );
  }
}
