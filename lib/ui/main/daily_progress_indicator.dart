// Copyright (c) 2021. Alexandr Moroz

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/colors.dart';

class WaveClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const lowPoint = 30.0;
    const highPoint = 60.0;
    path.lineTo(0, lowPoint / 2);
    path.quadraticBezierTo(size.width / 4, highPoint, size.width / 2, lowPoint);
    path.quadraticBezierTo(3 / 4 * size.width, 0, size.width, lowPoint);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class DailyProgressIndicator extends StatelessWidget {
  const DailyProgressIndicator(this.value);

  final double value;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 1000),
      bottom: MediaQuery.of(context).size.height * (min(0.85, value) - 1),
      width: MediaQuery.of(context).size.width,
      child: ClipPath(
        clipper: WaveClip(),
        child: Container(
          height: MediaQuery.of(context).size.height + 100,
          color: secondaryColor.resolve(context),
        ),
      ),
    );
  }
}
