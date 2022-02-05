// Copyright (c) 2021. Alexandr Moroz

import 'package:aqualife/ui/components/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget chevronBackIcon(BuildContext context, {Color? color}) => Icon(
      CupertinoIcons.chevron_back,
      color: (color ?? mainColor).resolve(context),
    );

Widget chevronForwardIcon(BuildContext context, {Color? color}) => Icon(
      CupertinoIcons.chevron_forward,
      color: (color ?? mainColor).resolve(context),
    );

Widget chevronFastForwardIcon(BuildContext context, {Color? color}) => Icon(
      CupertinoIcons.chevron_right_circle,
      color: (color ?? mainColor).resolve(context),
    );

Widget chartIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.chart_bar_alt_fill,
      size: size ?? 32,
      color: (color ?? mainColor).resolve(context),
    );

Widget plusIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.plus_circle_fill,
      size: size ?? 96,
      color: (color ?? mainColor).resolve(context),
    );

Widget plusOutlinedIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.plus_circle,
      size: size ?? 56,
      color: (color ?? mainColor).resolve(context),
    );

Widget minusOutlinedIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.minus_circle,
      size: size ?? 56,
      color: (color ?? mainColor).resolve(context),
    );

Widget editIcon(BuildContext context, {Color? color, double? size}) => Icon(
      CupertinoIcons.pencil_circle,
      size: size ?? 42,
      color: (color ?? mainColor).resolve(context),
    );
