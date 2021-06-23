// Copyright (c) 2021. Alexandr Moroz

import 'package:aqualife/ui/components/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget chevronBackIcon(BuildContext context, {Color? color}) => Icon(
      CupertinoIcons.chevron_back,
      color: CupertinoDynamicColor.maybeResolve(color, context),
    );

Widget chevronForwardIcon(BuildContext context, {Color? color}) => Icon(
      CupertinoIcons.chevron_forward,
      color: CupertinoDynamicColor.maybeResolve(color, context),
    );

Widget chartIcon(BuildContext context, {Color? color}) => Icon(
      CupertinoIcons.chart_bar_alt_fill,
      color: CupertinoDynamicColor.resolve(color ?? mainColor, context),
    );

Widget menuIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.bars,
      size: size ?? 42,
      color: CupertinoDynamicColor.resolve(color ?? mainColor, context),
    );

Widget plusIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.plus_circle_fill,
      size: size ?? 96,
      color: CupertinoDynamicColor.resolve(color ?? mainColor, context),
    );

Widget closeIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.clear_circled_solid,
      size: size ?? 96,
      color: CupertinoDynamicColor.resolve(color ?? mainColor, context),
    );

Widget homeIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.home,
      size: size ?? 32,
      color: CupertinoDynamicColor.resolve(color ?? mainColor, context),
    );
