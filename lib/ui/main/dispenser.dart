// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../services/globals.dart';
import '../components/am_slider.dart';
import '../components/colors.dart';
import '../components/text_widgets.dart';

class Dispenser extends StatelessWidget {
  const Dispenser({required this.value, required this.onDragCompleted});

  @protected
  final num value;
  @protected
  final Function(int, dynamic, dynamic) onDragCompleted;

  static const double max = 1000;

  List<AMSliderFixedValue> get steps => [
        AMSliderFixedValue(percent: 10, value: max * 0.1),
        AMSliderFixedValue(percent: 20, value: max * 0.2),
        AMSliderFixedValue(percent: 30, value: max * 0.3),
        AMSliderFixedValue(percent: 40, value: max * 0.4),
        AMSliderFixedValue(percent: 50, value: max * 0.5),
        AMSliderFixedValue(percent: 60, value: max * 0.6),
        AMSliderFixedValue(percent: 70, value: max * 0.7),
        AMSliderFixedValue(percent: 80, value: max * 0.8),
        AMSliderFixedValue(percent: 90, value: max * 0.9),
        AMSliderFixedValue(percent: 100, value: max),
      ];

  // int percentByValue(num v) => steps.firstWhere((s) => s.value == v).percent;

  @override
  Widget build(BuildContext context) {
    final sliderWidth = MediaQuery.of(context).size.shortestSide;
    final borderR = sliderWidth * 0.1;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: secondaryFillColor.resolve(context),
        borderRadius: BorderRadius.circular(borderR),
      ),
      child: Column(
        children: [
          NormalText(
            '${Intl.message(settings.measureUnitCode, name: settings.measureUnitCode)}',
            color: mainColor,
            padding: EdgeInsets.only(top: sidePadding, bottom: sidePadding * 2),
          ),
          Expanded(
            child: AMSlider(
              min: 0,
              max: max,
              step: const AMSliderStep(step: max / 20),
              rtl: true,
              jump: true,
              tooltip: AMSliderTooltip(disabled: true),
              handlerHeight: 0,
              handler: AMSliderHandler(child: Container()),
              trackBar: AMSliderTrackBar(
                activeTrackBarHeight: sliderWidth,
                activeTrackBar: BoxDecoration(color: secondaryColor.resolve(context)),
                inactiveTrackBar: const BoxDecoration(color: Colors.transparent),
              ),
              hatchMark: AMSliderHatchMark(
                labels: steps
                    .map(
                      (s) => AMSliderHatchMarkLabel(
                        percent: s.percent,
                        label: MediumText(
                          '—  ${s.value.round()}  —',
                          color: mainColor,
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
              values: [value.toDouble()],
              axis: Axis.vertical,
              onDragCompleted: onDragCompleted,
            ),
          ),
        ],
      ),
    );
  }
}
