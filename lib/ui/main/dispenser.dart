// Copyright (c) 2021. Alexandr Moroz

import 'dart:math';

import 'package:aqualife/services/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../components/buttons.dart';
import '../components/icons.dart';
import '../main/dispenser_slider.dart';

part 'dispenser.g.dart';

class Dispenser extends StatefulWidget {
  @override
  _DispenserState createState() => _DispenserState();
}

class _DispenserState = _DispenserStateBase with _$_DispenserState;

@StoreConfig(hasToString: false)
abstract class _DispenserStateBase extends State<Dispenser> with Store {
  @observable
  bool showSlider = false;

  @action
  void setSlider(bool slider) {
    showSlider = slider;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Observer(
        builder: (_) => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) => SizeTransition(sizeFactor: animation, child: child),
                child: showSlider
                    ? DispenserSlider(
                        value: settings.lastShotValue.toDouble(),
                        onDragCompleted: (int _, dynamic lowerValue, dynamic __) {
                          if (lowerValue is num) {
                            recordsState.addRecord(quantity: lowerValue.toInt());
                            setSlider(false);
                          }
                        },
                      )
                    : Container(),
              ),
            ),
            Button.icon(
              Transform.rotate(angle: (showSlider ? pi : 0) / 4, child: plusIcon(context)),
              () => setSlider(!showSlider),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
