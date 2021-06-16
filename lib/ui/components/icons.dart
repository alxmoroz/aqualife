// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget get chevronBack => const Icon(CupertinoIcons.chevron_back);

Widget get chevronForward => const Icon(CupertinoIcons.chevron_forward);

Widget get chartIcon => const Icon(CupertinoIcons.chart_bar_alt_fill, color: CupertinoColors.activeBlue);
// Widget get chartIcon => const Icon(CupertinoIcons.chart_bar_circle_fill);

Widget menuIcon(BuildContext ctx) => Stack(
      alignment: Alignment.topCenter,
      children: [
        Icon(CupertinoIcons.bars, size: 41, color: CupertinoDynamicColor.resolve(CupertinoColors.systemGrey4, ctx)),
        Icon(CupertinoIcons.bars, size: 40, color: CupertinoDynamicColor.resolve(CupertinoColors.activeBlue, ctx)),
      ],
    );

Widget plusIcon(BuildContext ctx) => Stack(
      alignment: Alignment.center,
      children: [
        Icon(CupertinoIcons.drop_fill, size: 94, color: CupertinoDynamicColor.resolve(CupertinoColors.systemGrey4, ctx)),
        Icon(CupertinoIcons.drop_fill, size: 90, color: CupertinoDynamicColor.resolve(CupertinoColors.activeBlue, ctx)),
        Icon(CupertinoIcons.plus, size: 30, color: CupertinoDynamicColor.resolve(CupertinoColors.systemGrey4, ctx)),
      ],
    );
