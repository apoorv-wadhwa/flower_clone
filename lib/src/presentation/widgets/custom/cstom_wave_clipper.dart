import 'package:flutter/material.dart';

class CustomWaveClipperOne extends CustomClipper<Path> {
  /// reverse the wave direction in vertical axis
  bool reverse;

  /// flip the wave direction horizontal axis
  bool flip;

  CustomWaveClipperOne({this.reverse = false, this.flip = false});

  @override
  Path getClip(Size size) {
    double h = size.height;
    double w = size.width;

    final path = Path();
    path.lineTo(0, h);
    path.quadraticBezierTo(
      w * 0.15,
      h - 100,
      w * 0.5,
      h - 50,
    );
    path.quadraticBezierTo(
      w,
      h - 100,
      w,
      0,
    );

    path.lineTo(w, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
