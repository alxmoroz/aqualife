import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class DailyProgressWaveIndicator extends StatefulWidget {
  const DailyProgressWaveIndicator(this.percent);

  final double percent;

  @override
  _DailyProgressWaveIndicatorState createState() => _DailyProgressWaveIndicatorState();
}

class _DailyProgressWaveIndicatorState extends State<DailyProgressWaveIndicator> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      // alignment: Alignment.bottomCenter,
      bottom: MediaQuery.of(context).size.height * (widget.percent - 1),
      width: MediaQuery.of(context).size.width,
      child: ClipPath(
        clipper: WaveClip(),
        child: Container(
          height: MediaQuery.of(context).size.height + 80,
          color: Colors.lightBlue,
        ),
      ),
    );
  }
}
