// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'text/text_widgets.dart';

class Button extends StatelessWidget {
  const Button(this.title, this.onPressed, {this.child, this.color, this.titleColor, this.padding, this.icon});

  const Button.icon(this.icon, this.onPressed, {this.color, this.padding})
      : title = null,
        child = icon,
        titleColor = null;

  final String? title;
  final VoidCallback? onPressed;
  final Widget? child;
  final Widget? icon;
  final Color? color;
  final Color? titleColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: padding ?? EdgeInsets.zero,
      onPressed: onPressed,
      color: color,
      disabledColor: CupertinoColors.systemGrey5,
      child: child ?? MediumText(title ?? '', color: titleColor ?? mainColor),
    );
  }
}
