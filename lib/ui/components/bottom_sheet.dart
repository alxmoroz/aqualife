// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../services/globals.dart';
import '../components/colors.dart';
import '../components/notch.dart';

class AMBottomSheet extends StatelessWidget {
  const AMBottomSheet(this.bodyWidget);

  final Widget bodyWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor.resolve(context),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Notch(),
              bodyWidget,
              SizedBox(height: sidePadding * 2),
            ],
          ),
        ),
      ),
    );
  }
}
