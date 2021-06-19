// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';

Color get darkColor => const CupertinoDynamicColor.withBrightness(color: Color(0xFF333333), darkColor: Color(0xFFCCCCCC));

Color get tealColor => const CupertinoDynamicColor.withBrightness(
      color: Color.fromARGB(255, 90, 200, 250),
      darkColor: Color.fromARGB(255, 0, 113, 164),
    );

Color get mainColor => const CupertinoDynamicColor.withBrightness(
      color: Color.fromARGB(255, 0, 113, 164),
      darkColor: Color.fromARGB(255, 90, 200, 250),
    );

Color get mainColorBg => const CupertinoDynamicColor.withBrightness(
      color: Color.fromARGB(50, 0, 113, 164),
      darkColor: Color.fromARGB(50, 90, 200, 250),
    );

Color get backgroundColor => CupertinoColors.systemGrey5;

Color get navbarBgColor => CupertinoColors.systemFill;
// Color get navbarBgColor => const CupertinoDynamicColor.withBrightness(
//       color: Color.fromARGB(170, 200, 215, 240),
//       darkColor: Color.fromARGB(170, 40, 50, 60),
//     );
