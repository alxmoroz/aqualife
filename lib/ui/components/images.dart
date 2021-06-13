// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxDecoration bgDecoration(BuildContext context) => const BoxDecoration(
      gradient: LinearGradient(colors: [Color(0xFF6699FF), Color(0xFFEEEEEE)]),
      // image: DecorationImage(
      //   image: const AssetImage('assets/images/background.png'),
      //   fit: BoxFit.fill,
      //   colorFilter: CupertinoTheme.brightnessOf(context) == Brightness.dark ? null : const ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.overlay),
      // ),
    );
