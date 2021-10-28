// Copyright (c) 2021. Alexandr Moroz

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../services/globals.dart';
import '../components/colors.dart';
import '../components/icons.dart';
import '../components/material_wrapper.dart';
import '../components/navbar.dart';
import '../stats/month_selector.dart';
import '../stats/records_list_view.dart';

class StatisticsView extends StatelessWidget {
  static String get routeName => 'StatisticsView';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: navBar(context, middle: MonthSelector()),
      backgroundColor: backgroundColor,
      child: materialWrap(
        Stack(
          children: [
            RecordsListView(),
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRect(
                child: Container(
                  color: CupertinoDynamicColor.resolve(mainFillColor, context),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 9, sigmaY: 9),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(bottom: sidePadding),
                      title: homeIcon(context),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
