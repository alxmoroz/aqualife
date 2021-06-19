// Copyright (c) 2021. Alexandr Moroz

import 'package:aqualife/services/globals.dart';
import 'package:aqualife/ui/main/dispenser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../components/buttons.dart';
import '../components/colors.dart';
import '../components/icons.dart';
import '../components/text/text_widgets.dart';
import '../statistics/statistics_view.dart';
import 'daily_progress_indicator.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  void updateState() {}

  @override
  void initState() {
    updateState();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget quantityText(String title) {
      return Center(
        child: MediumText(title, size: isTablet ? 65 : 50, color: mainColor),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (BuildContext innerCtx) => Button.icon(menuIcon(context), () => Scaffold.of(innerCtx).openDrawer()),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: CupertinoDynamicColor.resolve(backgroundColor, context),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: sidePadding),
                ListTile(
                  leading: chartIcon(context),
                  title: MediumText(loc.statistics),
                  trailing: chevronForwardIcon(context, color: darkColor),
                  onTap: () => Navigator.of(context).popAndPushNamed(StatisticsView.routeName),
                ),
                const Spacer(),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  LightText(packageInfo.appName),
                  NormalText(settings.version, padding: const EdgeInsets.only(left: 6)),
                ]),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: CupertinoDynamicColor.resolve(backgroundColor, context),
        child: Observer(
          builder: (_) => Stack(
            children: [
              DailyProgressIndicator(recordsState.waterQuantityToday / recordsState.dayQuota),
              quantityText(
                '${recordsState.waterQuantityToday} ${Intl.message(settings.measureUnitCode, name: settings.measureUnitCode)}',
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Dispenser(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
