// Copyright (c) 2021. Alexandr Moroz

import 'dart:math';
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

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool showSlider = false;

  static const Duration duration = Duration(milliseconds: 300);

  void toggleSliderVisibility() => setState(() {
        showSlider = !showSlider;
      });

  Widget quantityText(String title) {
    return Center(
      child: MediumText(title, size: isTablet ? 65 : 50, color: mainColor),
    );
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
              if (showSlider) BackdropFilter(filter: ImageFilter.blur(sigmaX: 9, sigmaY: 9), child: Container()),
              AnimatedSwitcher(
                duration: duration,
                child: showSlider
                    ? Container(
                        // TODO: цвет можно подобрать как в АктМониторе для таббара
                        color: CupertinoDynamicColor.resolve(navbarBgColor, context),
                        child: Column(
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                            Expanded(
                              child: DispenserSlider(
                                value: settings.lastShotValue,
                                onDragCompleted: (int _, dynamic lowerValue, dynamic __) {
                                  if (lowerValue is num) {
                                    recordsState.addRecord(quantity: lowerValue.toInt());
                                  }
                                  toggleSliderVisibility();
                                },
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                          ],
                        ),
                      )
                    : null,
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedContainer(
                    duration: duration,
                    transformAlignment: Alignment.center,
                    transform: Matrix4.rotationZ(showSlider ? pi / 4 : 0),
                    child: Button.icon(plusIcon(context), () => toggleSliderVisibility()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
