// Copyright (c) 2021. Alexandr Moroz

import 'dart:ui';

import 'package:aqualife/services/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../components/buttons.dart';
import '../components/colors.dart';
import '../components/icons.dart';
import '../components/text/text_widgets.dart';
import '../main/dispenser_slider.dart';
import 'daily_progress_indicator.dart';
import 'drawer.dart';

class MainView extends StatelessWidget {
  void showSliderModal(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      filter: ImageFilter.blur(sigmaX: 9, sigmaY: 9),
      builder: (BuildContext context) => Container(
        color: navbarBgColor,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              Expanded(
                child: DispenserSlider(
                  value: settings.lastShotValue,
                  onDragCompleted: (int _, dynamic lowerValue, dynamic __) {
                    if (lowerValue is num) {
                      recordsState.addRecord(quantity: lowerValue.toInt());
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Button.icon(
                closeIcon(context),
                () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
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
              //TODO : слайдер
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Button.icon(plusIcon(context), () => showSliderModal(context)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
