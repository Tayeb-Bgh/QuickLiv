import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/constants.dart' as kColors;
import 'package:flutter_svg/flutter_svg.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path = Path();

    // Nouveau chemin basé sur le fond que tu préfères
    path.moveTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
      0,
      size.height * 0.85,
    ); // Ajustement pour respecter le ratio de hauteur 72/80
    path.cubicTo(
      size.width * 0.68,
      size.height * 0.3875,
      size.width * 0.9465,
      size.height * 1.1875,
      size.width,
      size.height * 0.63125,
    );
    path.lineTo(size.width, 0);
    path.close();

    // Mise à jour de la couleur et du style de remplissage
    Paint paintFill = Paint()..style = PaintingStyle.fill;
    paintFill.color =
        kColors.kPrimaryRed; // Remplacer par ta couleur préférée si besoin
    canvas.drawPath(path, paintFill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
class CustomTopBar extends StatelessWidget {
  final String title;

  const CustomTopBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Positioned(
          left: 10,
          top: height * 0.046,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          right: 9,
          top: height * 0.053,
          child: Row(
            children: [
              _buildIcon("assets/images/order.svg"),
              const SizedBox(width: 6),
              _buildIcon("assets/images/cart.svg", 22, 22),
              const SizedBox(width: 6),
              _buildIcon("assets/images/user.svg"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIcon(String assetPath, [double? widthIcon, double? heightIcon]) {
    return SizedBox(
      width: 32,
      height: 32,
      child: Container(
        decoration: BoxDecoration(
          color: kColors.kDarkGray,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SvgPicture.asset(
            assetPath,
            width: widthIcon ?? 18,
            height: heightIcon ?? 18,
          ),
        ),
      ),
    );
  }
}
