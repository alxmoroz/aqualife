import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/buttons.dart';
import '../components/colors.dart';
import '../components/icons.dart';
import '../components/images.dart';
import '../components/material_wrapper.dart';
import '../components/text/text_widgets.dart';
import 'daily_progress_wave_indicator.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  double dayQuota = 2000;
  double dayValue = 0;

  void updateState() {
    dayQuota = 2500;
    dayValue = 1000;
  }

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
    return CupertinoPageScaffold(
      child: materialWrap(
        Container(
          decoration: bgDecoration(context),
          child: Stack(
            children: [
              DailyProgressWaveIndicator(dayValue / dayQuota),
              Align(
                alignment: Alignment.bottomCenter,
                child: Button(
                  null,
                  null,
                  padding: const EdgeInsets.all(30),
                  child: Container(child: plusIcon),
                ),
              ),
              Center(
                child: H3('AquaLife', color: darkColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
