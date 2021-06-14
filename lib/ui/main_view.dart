import 'package:aqualife/ui/components/colors.dart';
import 'package:aqualife/ui/components/images.dart';
import 'package:aqualife/ui/components/text/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return CupertinoPageScaffold(
      child: Container(
        decoration: bgDecoration(context),
        child: SafeArea(
          child: Center(
            child: H3('AquaLife', color: darkColor),
          ),
        ),
      ),
    );
  }
}
