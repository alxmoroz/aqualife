// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../services/globals.dart';
import 'colors.dart';

class TextShadow {
  const TextShadow(this.color, this.offset);

  final Color color;

  @protected
  final Offset offset;

  double get dx => offset.dx;
  double get dy => offset.dy;
}

class NormalText extends StatelessWidget {
  const NormalText(
    this.text, {
    super.key,
    this.size,
    this.sizeScale,
    this.color,
    this.weight,
    this.align,
    this.padding,
    this.height,
    this.overflow,
    this.shadow,
  });

  @protected
  final String text;
  @protected
  final Color? color;
  @protected
  final FontWeight? weight;
  @protected
  final TextAlign? align;
  @protected
  final double? size;
  @protected
  final double? sizeScale;
  @protected
  final EdgeInsets? padding;
  @protected
  final double? height;
  @protected
  final TextOverflow? overflow;
  @protected
  final TextShadow? shadow;

  @override
  Widget build(BuildContext context) {
    final cupertinoTS = CupertinoTheme.of(context).textTheme.textStyle;
    final textStyle = cupertinoTS.copyWith(
      color: CupertinoDynamicColor.maybeResolve(color ?? darkColor, context),
      fontWeight: weight ?? cupertinoTS.fontWeight,
      fontSize: (size ?? cupertinoTS.fontSize ?? (isTablet ? 22 : 18)) * (sizeScale ?? 1),
      height: height ?? cupertinoTS.height,
    );
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Stack(
        children: [
          if (shadow != null)
            Positioned(
              top: shadow!.dy,
              left: shadow!.dx,
              child: Text(
                text,
                style: textStyle.copyWith(color: CupertinoDynamicColor.maybeResolve(shadow!.color, context)),
                textAlign: align,
                overflow: overflow,
              ),
            ),
          Text(text, style: textStyle, textAlign: align, overflow: overflow),
        ],
      ),
    );
  }
}

class LightText extends NormalText {
  const LightText(super.text, {super.key, super.size, super.color, FontWeight? weight, super.align, super.padding, super.sizeScale})
      : super(
          weight: weight ?? FontWeight.w300,
        );
}

class MediumText extends NormalText {
  const MediumText(super.text, {super.key, super.size, super.color, FontWeight? weight, super.align, super.padding, super.shadow, super.sizeScale})
      : super(
          weight: weight ?? FontWeight.w500,
        );
}

class H3 extends MediumText {
  const H3(super.text, {super.key, super.color, super.weight, super.align, super.padding, super.shadow})
      : super(
          sizeScale: 1.2,
        );
}
