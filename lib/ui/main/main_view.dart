// Copyright (c) 2021. Alexandr Moroz

import 'package:aqualife/services/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../components/buttons.dart';
import '../components/colors.dart';
import '../components/icons.dart';
import '../components/images.dart';
import '../components/text/text_widgets.dart';
import '../statistics/statistics_view.dart';
import 'daily_progress_wave_indicator.dart';

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
          color: CupertinoDynamicColor.resolve(CupertinoColors.secondarySystemBackground, context),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: cardPadding),
                ListTile(
                  leading: chartIcon,
                  title: MediumText(loc.statistics),
                  trailing: Icon(CupertinoIcons.chevron_forward, color: CupertinoDynamicColor.resolve(darkColor, context)),
                  onTap: () => Navigator.of(context).popAndPushNamed(StatisticsView.routeName),
                ),
                const Spacer(),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  NormalText(packageInfo.appName, weight: FontWeight.w300),
                  NormalText(
                    settings.version,
                    padding: const EdgeInsets.only(left: 6),
                  )
                ]),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: bgDecoration(context),
        child: Observer(
          builder: (_) => Stack(
            children: [
              DailyProgressWaveIndicator(recordsState.waterQuantityToday / recordsState.dayQuota),
              Align(
                alignment: Alignment.bottomCenter,
                child: Button(
                  null,
                  () => recordsState.addRecord(quantity: 50),
                  padding: const EdgeInsets.all(30),
                  child: Container(child: plusIcon(context)),
                ),
              ),
              Center(
                child: H3(recordsState.waterQuantityToday.toString(), color: darkColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
