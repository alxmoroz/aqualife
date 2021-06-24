// Copyright (c) 2021. Alexandr Moroz

import 'package:aqualife/services/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../components/colors.dart';
import '../components/text/text_widgets.dart';

class RecordsListView extends StatelessWidget {
  int get _daysInMonthCount => DateTime(recordsState.selectedMonth.year, recordsState.selectedMonth.month + 1, 0).day;

  List<DateTime> get _days {
    final now = DateTime.now();
    return List<DateTime>.generate(
      _daysInMonthCount,
      (int index) => DateTime(recordsState.selectedMonth.year, recordsState.selectedMonth.month, index + 1),
    ).where((d) => d.isBefore(now)).toList(growable: false).reversed.toList(growable: false);
  }

  Widget itemBuilder(BuildContext context, int index) {
    final date = _days[index];
    final value = recordsState.waterQuantityForDate(date);
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  NormalText(DateFormat.MMMEd().format(date), align: TextAlign.right, weight: FontWeight.w300),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Stack(alignment: Alignment.centerLeft, children: [
              LinearProgressIndicator(
                value: value / recordsState.dayQuota,
                color: CupertinoDynamicColor.resolve(secondaryColor, context),
                minHeight: 28,
                backgroundColor: Colors.transparent,
              ),
              H3(
                '$value ${Intl.message(settings.measureUnitCode, name: settings.measureUnitCode)}',
                padding: const EdgeInsets.only(left: 4),
              )
            ]),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView.builder(
        itemBuilder: itemBuilder,
        itemCount: _days.length,
      ),
    );
  }
}
