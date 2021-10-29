// Copyright (c) 2021. Alexandr Moroz

import 'package:aqualife/ui/components/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget chevronBackIcon(BuildContext context, {Color? color}) => Icon(
      CupertinoIcons.chevron_back,
      color: CupertinoDynamicColor.maybeResolve(color ?? mainColor, context),
    );

Widget chevronForwardIcon(BuildContext context, {Color? color}) => Icon(
  CupertinoIcons.chevron_forward,
      color: CupertinoDynamicColor.maybeResolve(color ?? mainColor, context),
    );

Widget chartIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.chart_bar_alt_fill,
      size: size ?? 32,
      color: CupertinoDynamicColor.resolve(color ?? mainColor, context),
    );

Widget plusIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.plus_circle_fill,
      size: size ?? 96,
      color: CupertinoDynamicColor.resolve(color ?? mainColor, context),
    );

Widget plusOutlinedIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.plus_circle,
      size: size ?? 56,
      color: CupertinoDynamicColor.resolve(color ?? mainColor, context),
    );

Widget minusOutlinedIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.minus_circle,
      size: size ?? 56,
      color: CupertinoDynamicColor.resolve(color ?? mainColor, context),
    );

Widget editIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.pencil_circle,
      size: size ?? 42,
      color: CupertinoDynamicColor.resolve(color ?? mainColor, context),
    );
