import 'package:flutter/material.dart';

class CouponExter extends StatelessWidget {
  const CouponExter({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 158,
      child: CustomPaint(
        painter: MyPainter(),
        child: Container(),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = 300.0;
    final height = 158.0;

    Paint redPaint = Paint()
      ..color = const Color(0xffE13838)
      ..style = PaintingStyle.fill;

    Paint whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), redPaint);

    // Dessiner les cercles blancs

    // Coins
    // Coin supérieur gauche
    canvas.drawCircle(Offset(0, 6), 20, whitePaint);
    // Coin supérieur droit
    canvas.drawCircle(Offset(width, 5), 20, whitePaint);
    // Coin inférieur gauche
    canvas.drawCircle(Offset(2, height), 20, whitePaint);
    // Coin inférieur droit
    canvas.drawCircle(Offset(width - 4, height), 20, whitePaint);

    // Cercles du milieu
    // Cercle gauche
    canvas.drawCircle(Offset(-2, height / 2 + 0.5), 13.5, whitePaint);
    // Cercle droit
    canvas.drawCircle(Offset(width + 2, height / 2 + 0.5), 13.5, whitePaint);

    // Petites ellipses - côté gauche (haut)
    canvas.drawOval(
      Rect.fromCenter(center: Offset(1, 54), width: 9, height: 6),
      whitePaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(1, 40), width: 9, height: 6),
      whitePaint,
    );

    // Petites ellipses - côté gauche (bas)
    canvas.drawOval(
      Rect.fromCenter(center: Offset(1, 114), width: 9, height: 7),
      whitePaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(1, 100), width: 9, height: 7),
      whitePaint,
    );

    // Petites ellipses - côté droit (haut)
    canvas.drawOval(
      Rect.fromCenter(center: Offset(width - 1, 54), width: 9, height: 6),
      whitePaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(width - 1, 40), width: 9, height: 6),
      whitePaint,
    );

    // Petites ellipses - côté droit (bas)
    canvas.drawOval(
      Rect.fromCenter(center: Offset(width - 1, 114), width: 9, height: 7),
      whitePaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(width - 1, 100), width: 9, height: 7),
      whitePaint,
    );

    final centerRect = Rect.fromLTWH(25, 15, width - 50, height - 30);
    canvas.drawRect(centerRect, whitePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

