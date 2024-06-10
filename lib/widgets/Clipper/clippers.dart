import 'package:flutter/material.dart';

class GetStartedClipperPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path1 = Path()
      ..lineTo(size.width * 0.95, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width * 0.95, size.height)
      ..lineTo(0, size.height);

    return path1;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class PersonalDetailsClipperPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path1 = Path()
      ..lineTo(size.width * 0.95, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width * 0.95, size.height)
      ..lineTo(0, size.height)
      ..lineTo(size.width - size.width * 0.95, size.height / 2);

    return path1;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}