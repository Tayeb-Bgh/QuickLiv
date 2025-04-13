import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';

class LoginAppBar extends StatelessWidget {
  const LoginAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return CustomPaint(
      painter: MyPainter1(),
      child: Container(
        height: height * 0.3,
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(height * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                Text(
                  'QuickLiv',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
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
