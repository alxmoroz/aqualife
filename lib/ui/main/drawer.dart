// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../services/globals.dart';
import '../components/colors.dart';
import '../components/text_widgets.dart';
import '../stats/month_selector.dart';
import '../stats/records_list_view.dart';

class ALDrawer extends StatelessWidget {
  const ALDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: backgroundColor.resolve(context),
        child: SafeArea(
            child: Column(
          children: [
            const SizedBox(height: AppConstants.sidePadding),
            // ListTile(
            //   leading: chartIcon(context),
            //   title: MediumText(loc.statistics),
            //   trailing: chevronForwardIcon(context, color: darkColor),
            //   onTap: () => Navigator.of(context).popAndPushNamed(StatisticsView.routeName),
            // ),
            const MonthSelector(),
            const Expanded(child: RecordsListView()),
            // const Spacer(),
            const SizedBox(height: AppConstants.sidePadding),
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
