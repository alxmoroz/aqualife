// Copyright (c) 2021. Alexandr Moroz

import 'package:aqualife/ui/components/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget get chevronBack => const Icon(CupertinoIcons.chevron_back);

Widget get chevronForward => const Icon(CupertinoIcons.chevron_forward);

Widget chartIcon(BuildContext context, [Color? color]) => Icon(
      CupertinoIcons.chart_bar_alt_fill,
      color: CupertinoDynamicColor.resolve(color ?? mainColor, context),
    );

Widget menuIcon(BuildContext context, [Color? color, double? size]) => Icon(
      CupertinoIcons.bars,
      size: size ?? 42,
      color: CupertinoDynamicColor.resolve(color ?? mainColor, context),
    );

Widget plusIcon(BuildContext context, [Color? color, double? size]) => Icon(
      CupertinoIcons.plus_circle_fill,
      size: size ?? 96,
      color: CupertinoDynamicColor.resolve(color ?? mainColor, context),
    );

Widget homeIcon(BuildContext context, [Color? color, double? size]) => Icon(
      CupertinoIcons.home,
      size: size ?? 32,
      color: CupertinoDynamicColor.resolve(color ?? mainColor, context),
    );
