// Copyright (c) 2021. Alexandr Moroz

import 'dart:ui';

import 'package:aqualife/services/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/colors.dart';
import '../components/text/text_widgets.dart';
import '../components/xslider_ns.dart';

class DispenserSlider extends StatefulWidget {
  const DispenserSlider({required this.value, required this.onDragCompleted});

  @protected
  final double value;
  @protected
  final Function(int, dynamic, dynamic) onDragCompleted;

  @override
  _DispenserSliderState createState() => _DispenserSliderState();
}

class _DispenserSliderState extends State<DispenserSlider> {
  late int dragValue;

  @override
  void initState() {
    dragValue = widget.value.toInt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<int> steps = [50, 125, 250, 330, 500, 650, 750, 1000];

    return Container(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 9, sigmaY: 9),
        child: FlutterSlider(
          min: 0,
          max: 1000,
          step: const FlutterSliderStep(step: 10),
          rtl: true,
          jump: true,
          tooltip: FlutterSliderTooltip(disabled: true),
          handlerHeight: 58,
          handlerWidth: 120,
          handler: FlutterSliderHandler(
            decoration: BoxDecoration(
                color: CupertinoDynamicColor.resolve(mainColor, context),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: CupertinoDynamicColor.resolve(tealColor, context), width: 3)),
            child: H3(
              '+ $dragValue ${Intl.message(settings.measureUnitCode, name: settings.measureUnitCode)}',
              color: tealColor,
              align: TextAlign.center,
              padding: const EdgeInsets.all(8),
            ),
          ),
          handlerAnimation: const FlutterSliderHandlerAnimation(scale: 1),
          trackBar: FlutterSliderTrackBar(
            activeTrackBarHeight: 90,
            inactiveTrackBarHeight: 4,
            inactiveTrackBar: BoxDecoration(color: CupertinoDynamicColor.resolve(mainColor, context)),
            activeTrackBar: BoxDecoration(
              color: CupertinoDynamicColor.resolve(tealColor, context),
              border: Border.all(color: CupertinoDynamicColor.resolve(mainColor, context), width: 3),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          hatchMark: FlutterSliderHatchMark(
            labels: steps
                .map(
                  (v) => FlutterSliderHatchMarkLabel(
                    percent: v / 10,
                    label: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: CupertinoDynamicColor.resolve(mainColor, context)),
                        borderRadius: BorderRadius.circular(10),
                        color: CupertinoDynamicColor.resolve(tealColor, context),
                      ),
                      child: NormalText(
                        '$v ${Intl.message(settings.measureUnitCode, name: settings.measureUnitCode)}',
                        color: mainColor,
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      ),
                    ),
                  ),
                )
                .toList(growable: false),
          ),
          values: [dragValue.toDouble()],
          axis: Axis.vertical,
          onDragCompleted: widget.onDragCompleted,
          onDragging: (_, dynamic lowerValue, dynamic __) {
            if (lowerValue is num && lowerValue != dragValue) {
              setState(() => dragValue = lowerValue.toInt());
            }
          },
        ),
      ),
    );
  }
}
