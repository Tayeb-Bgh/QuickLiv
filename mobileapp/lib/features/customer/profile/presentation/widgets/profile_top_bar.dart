import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/constants.dart';

class ProfileTopBar extends CustomPainter {
  final bool isDarkMode;

  ProfileTopBar({required this.isDarkMode});

  @override
  void paint(Canvas canvas, Size size) {
    final color = isDarkMode ? kPrimaryDark : kPrimaryWhite;
    Paint backgroundPaint = Paint()..color = color;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      backgroundPaint,
    );

    Paint paint = Paint()..color = kPrimaryRed;

    Path path = Path();
    path.lineTo(size.width, 0);
    path.cubicTo(size.width, 0, 0, 0, 0, 0);
    path.cubicTo(0, 0, 0, size.height, 0, size.height);
    path.cubicTo(
      size.width * 0.68,
      size.height * 0.34,
      size.width * 0.96,
      size.height * 1.51,
      size.width,
      size.height * 0.7,
    );
    path.cubicTo(size.width, size.height * 0.7, size.width, 0, size.width, 0);
    path.cubicTo(size.width, 0, size.width, 0, size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
