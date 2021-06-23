// Copyright (c) 2021. Alexandr Moroz

import 'package:aqualife/services/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/am_slider.dart';
import '../components/colors.dart';
import '../components/text/text_widgets.dart';

class DispenserSlider extends StatelessWidget {
  const DispenserSlider({required this.value, required this.onDragCompleted});

  @protected
  final num value;
  @protected
  final Function(int, dynamic, dynamic) onDragCompleted;

  List<AMSliderFixedValue> get steps => [
        AMSliderFixedValue(percent: 5, value: 50),
        AMSliderFixedValue(percent: 12, value: 125),
        AMSliderFixedValue(percent: 25, value: 250),
        AMSliderFixedValue(percent: 32, value: 330),
        AMSliderFixedValue(percent: 48, value: 500),
        AMSliderFixedValue(percent: 62, value: 650),
        AMSliderFixedValue(percent: 72, value: 750),
        AMSliderFixedValue(percent: 100, value: 1000),
      ];

  int percentByValue(num v) => steps.firstWhere((s) => s.value == v).percent;

  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(color: CupertinoDynamicColor.resolve(mainColor, context), width: 2);

    final sliderWidth = MediaQuery.of(context).size.shortestSide * 0.4;
    final borderR = BorderRadius.circular(40);

    return AMSlider(
      fixedValues: steps,
      rtl: true,
      jump: true,
      tooltip: AMSliderTooltip(disabled: true),
      handlerHeight: 0,
      handlerWidth: sliderWidth,
      handler: AMSliderHandler(
        decoration: BoxDecoration(
          color: CupertinoDynamicColor.resolve(mainColor, context),
          borderRadius: BorderRadius.circular(4),
          border: Border.fromBorderSide(borderSide),
        ),
        child: Container(),
      ),
      handlerAnimation: const AMSliderHandlerAnimation(scale: 1),
      trackBar: AMSliderTrackBar(
        activeTrackBarHeight: sliderWidth,
        inactiveTrackBarHeight: sliderWidth,
        inactiveTrackBar: BoxDecoration(
          color: Colors.transparent,
          border: Border.fromBorderSide(borderSide),
          borderRadius: borderR,
        ),
        activeTrackBar: BoxDecoration(
          color: CupertinoDynamicColor.resolve(tealColor, context),
          border: Border.fromBorderSide(borderSide),
          borderRadius: borderR,
        ),
      ),
      hatchMark: AMSliderHatchMark(
        labels: steps
            .map(
              (s) => AMSliderHatchMarkLabel(
                percent: s.percent,
                label: NormalText(
                  '— ${s.value} ${Intl.message(settings.measureUnitCode, name: settings.measureUnitCode)} —',
                  color: mainColor,
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                ),
              ),
            )
            .toList(growable: false),
      ),
      values: [percentByValue(value).toDouble()],
      axis: Axis.vertical,
      onDragCompleted: onDragCompleted,
    );
  }
}
