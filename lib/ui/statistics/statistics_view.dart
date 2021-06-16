// Copyright (c) 2021. Alexandr Moroz

import 'package:aqualife/services/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../components/material_wrapper.dart';
import '../components/navbar.dart';
import '../components/text/text_widgets.dart';
import '../statistics/month_selector.dart';

class StatisticsView extends StatelessWidget {
  static String get routeName => 'StatisticsView';

  int get _daysInMonthCount => DateTime(recordsState.selectedMonth.year, recordsState.selectedMonth.month + 1, 0).day;

  List<DateTime> get _days {
    final now = DateTime.now();
    return List<DateTime>.generate(
      _daysInMonthCount,
      (int index) => DateTime(recordsState.selectedMonth.year, recordsState.selectedMonth.month, index + 1),
    ).where((d) => d.isBefore(now)).toList(growable: false).reversed.toList(growable: false);
  }

  Widget itemBuilder(BuildContext ctx, int index) {
    final date = _days[index];
    return ListTile(
      title: NormalText(DateFormat.MMMMd().format(date)),
      trailing: NormalText(recordsState.waterQuantityForDate(date).toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: navBar(context, middle: MonthSelector()),
      child: materialWrap(
        Observer(
          builder: (_) => ListView.builder(
            itemBuilder: itemBuilder,
            itemCount: _days.length,
          ),
        ),
      ),
    );
  }
}
