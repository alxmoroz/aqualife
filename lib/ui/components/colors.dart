// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';

Color get darkColor => const CupertinoDynamicColor.withBrightness(
      color: Color(0xFF333333),
      darkColor: Color(0xFFCCCCCC),
    );

Color get backgroundColor => CupertinoColors.systemGrey5;

const Color _tealColor = Color.fromARGB(255, 90, 200, 250);
const Color _darkTealColor = Color.fromARGB(255, 0, 113, 164);

Color get mainColor => const CupertinoDynamicColor.withBrightness(
      color: _darkTealColor,
      darkColor: _tealColor,
    );

Color get secondaryColor => const CupertinoDynamicColor.withBrightness(
      color: _tealColor,
      darkColor: _darkTealColor,
    );

Color get mainFillColor => const CupertinoDynamicColor.withBrightness(
      color: Color.fromARGB(180, 215, 215, 220),
      darkColor: Color.fromARGB(150, 45, 55, 65),
    );

Color get secondaryFillColor => const CupertinoDynamicColor.withBrightness(
      color: Color.fromARGB(150, 245, 245, 250),
      darkColor: Color.fromARGB(150, 10, 15, 20),
    );

Color get appBarBgColor => const CupertinoDynamicColor.withBrightness(
      color: Color.fromARGB(0, 255, 255, 255),
      darkColor: Color.fromARGB(0, 0, 0, 0),
    );

extension ResolvedColor on Color {
  Color resolve(BuildContext ctx) => CupertinoDynamicColor.resolve(this, ctx);
}
