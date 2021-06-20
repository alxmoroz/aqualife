// Copyright (c) 2021. Alexandr Moroz

import 'package:aqualife/services/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../components/buttons.dart';
import '../components/colors.dart';
import '../components/icons.dart';
import '../components/text/text_widgets.dart';
import 'daily_progress_indicator.dart';
import 'dispenser.dart';
import 'drawer.dart';

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
          builder: (BuildContext innerCtx) => Button.icon(chartIcon(context), () => Scaffold.of(innerCtx).openDrawer()),
        ),
      ),
      drawer: ALDrawer(),
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
