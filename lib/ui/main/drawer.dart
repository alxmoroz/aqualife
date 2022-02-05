// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../services/globals.dart';
import '../components/colors.dart';
import '../components/text_widgets.dart';
import '../stats/month_selector.dart';
import '../stats/records_list_view.dart';

class ALDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: backgroundColor.resolve(context),
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(height: sidePadding),
            // ListTile(
            //   leading: chartIcon(context),
            //   title: MediumText(loc.statistics),
            //   trailing: chevronForwardIcon(context, color: darkColor),
            //   onTap: () => Navigator.of(context).popAndPushNamed(StatisticsView.routeName),
            // ),
            MonthSelector(),
            Expanded(child: RecordsListView()),
            // const Spacer(),
            SizedBox(height: sidePadding),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              LightText(packageInfo.appName),
              NormalText(settings.version, padding: const EdgeInsets.only(left: 6)),
            ]),
          ],
        )),
      ),
    );
  }
}
