import 'package:flutter/material.dart';

class Coupon extends StatelessWidget {
  final String TextLivraison;
  final String Pourcentage;
  final Widget? BlurCouponCard;
  const Coupon({
    super.key,
    required this.TextLivraison,
    required this.Pourcentage,
    this.BlurCouponCard,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 300,
          height: 158,
          child: CustomPaint(painter: MyPainter(), child: Container()),
        ),
        Container(
          width: 250,
          height: 130,
          margin: EdgeInsets.symmetric(horizontal: 25),

          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: ClipPath(
                  clipper: DiagonalClipper(),
                  child: Container(
                    width: 120,
                    color: Color(0xFFF5CB58),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.0, top: 0.0),
                      child: Text(
                        TextLivraison,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 20,
                top: 25,
                child: Container(
                  width: 132,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFE13838), width: 1),
                  ),
                  child: Center(
                    child: Text(
                      "COUPON",
                      style: TextStyle(
                        color: Color(0xFFE13838),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              // -30% texte
              Positioned(
                right: 20,
                bottom: 15,
                child: Text(
                  Pourcentage,
                  style: TextStyle(
                    color: Color(0xFFE13838),
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Petits cercles rouges
              Positioned(
                left: 50,
                bottom: 20,
                child: Column(
                  children: List.generate(3, (row) {
                    return Row(
                      children: List.generate(4, (col) {
                        return Padding(
                          padding: EdgeInsets.all(3),
                          child: CircleAvatar(
                            radius: 3,
                            backgroundColor: Color(0xFFE13838),
                          ),
                        );
                      }),
                    );
                  }),
                ),
              ),
              BlurCouponCard ?? SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = 300.0;
    final height = 158.0;

    Paint redPaint =
        Paint()
          ..color = const Color(0xffE13838)
          ..style = PaintingStyle.fill;

    Paint whitePaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), redPaint);

    canvas.drawCircle(Offset(0, 6), 20, whitePaint);

    canvas.drawCircle(Offset(width, 5), 20, whitePaint);

    canvas.drawCircle(Offset(2, height), 20, whitePaint);

    canvas.drawCircle(Offset(width - 4, height), 20, whitePaint);

    canvas.drawCircle(Offset(-2, height / 2 + 0.5), 13.5, whitePaint);

    canvas.drawCircle(Offset(width + 2, height / 2 + 0.5), 13.5, whitePaint);

    canvas.drawOval(
      Rect.fromCenter(center: Offset(1, 54), width: 9, height: 6),
      whitePaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(1, 40), width: 9, height: 6),
      whitePaint,
    );

    canvas.drawOval(
      Rect.fromCenter(center: Offset(1, 114), width: 9, height: 7),
      whitePaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(1, 100), width: 9, height: 7),
      whitePaint,
    );

    canvas.drawOval(
      Rect.fromCenter(center: Offset(width - 1, 54), width: 9, height: 6),
      whitePaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(width - 1, 40), width: 9, height: 6),
      whitePaint,
    );
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
