import 'package:aqualife/services/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../components/buttons.dart';
import '../components/colors.dart';
import '../components/icons.dart';
import '../components/images.dart';
import '../components/text/text_widgets.dart';
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
    return Container(
      decoration: bgDecoration(context),
      child: Observer(
        builder: (_) => Stack(
          children: [
            DailyProgressWaveIndicator(recordsState.todayWaterQuantity / recordsState.dayQuota),
            Align(
              alignment: Alignment.bottomCenter,
              child: Button(
                null,
                () => recordsState.addRecord(quantity: 50),
                padding: const EdgeInsets.all(30),
                child: Container(child: plusIcon),
              ),
            ),
            Center(
              child: H3(recordsState.todayWaterQuantity.toString(), color: darkColor),
            ),
          ],
        ),
      ),
    );
  }
}
