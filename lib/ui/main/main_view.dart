// Copyright (c) 2021. Alexandr Moroz

import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../services/globals.dart';
import '../components/buttons.dart';
import '../components/colors.dart';
import '../components/icons.dart';
import '../components/text/text_widgets.dart';
import '../main/dispenser.dart';
import 'daily_progress_indicator.dart';
import 'drawer.dart';
import 'records_edit_dialog.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  static const Duration duration = Duration(milliseconds: 300);
  static const Duration shortDuration = Duration(milliseconds: 150);

  // num get lastShotValue => settings.lastShotValue;
  bool showDispenser = false;

  void toggleDispenser() => setState(() => showDispenser = !showDispenser);

  Widget quantityText(String title) {
    return Center(
      child: MediumText(title, size: isTablet ? 80 : 65, color: mainColor),
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
              if (showDispenser)
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 9, sigmaY: 9),
                  child: GestureDetector(
                    onTap: toggleDispenser,
                    child: Container(color: CupertinoDynamicColor.resolve(mainFillColor, context)),
                  ),
                ),

              /// кнопка для редактирования
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Button.icon(
                    editIcon(context),
                    () => showRecordsEditDialog(context),
                    padding: EdgeInsets.all(sidePadding * 2),
                  ),
                ),
              ),

              /// диспенсер с кнопкой "+"
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                      Expanded(
                        child: SizedBox(
                          width: 140,
                          child: AnimatedOpacity(
                            duration: duration,
                            opacity: showDispenser ? 1 : 0,
                            child: Dispenser(
                              value: 0, //lastShotValue,
                              onDragCompleted: (int _, dynamic lowerValue, dynamic __) async {
                                if (!showDispenser) {
                                  return;
                                }
                                if (lowerValue is num) {
                                  await recordsState.addRecord(quantity: lowerValue.toInt());
                                }
                                Timer(shortDuration, toggleDispenser);
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: sidePadding),
                      AnimatedContainer(
                        duration: duration,
                        transformAlignment: Alignment.center,
                        transform: Matrix4.rotationZ(showDispenser ? pi / 4 : 0),
                        child: Button.icon(plusIcon(context), toggleDispenser),
                      ),
                    ],
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
