import 'package:flutter/material.dart';

class LoginAppBar extends StatelessWidget {
  const LoginAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return CustomPaint(
      painter: MyPainter1(),
      child: SizedBox(
        height: height * 0.36,
        width: double.infinity,
        child: Center(
          child: Image(
            image: AssetImage("assets/images/logo.png"),
            width: height * 0.3,
          ),
        ),
      ),
    );
  }
}

class MyPainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    paint.color = Color(0xffE13838);
    path = Path();
    path.lineTo(size.width * 0.97, -0.04);
    path.cubicTo(size.width * 0.97, -0.04, -0.03, -0.04, -0.03, -0.04);
    path.cubicTo(
      -0.03,
      -0.04,
      -0.03,
      size.height * 0.96,
      -0.03,
      size.height * 0.96,
    );
    path.cubicTo(
      size.width * 0.7,
      size.height * 0.3,
      size.width * 0.97,
      size.height * 1.47,
      size.width,
      size.height * 0.66,
    );
    path.cubicTo(
      size.width,
      size.height * 0.66,
      size.width,
      -0.01,
      size.width,
      -0.01,
    );
    path.cubicTo(size.width, -0.04, size.width, -0.04, size.width, -0.04);
    canvas.drawShadow(path, Colors.black.withOpacity(0.9), 8, true);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
