import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobileapp/features/auth/presentation/pages/login_page.dart';
import 'package:mobileapp/features/auth/presentation/providers/auth_provider.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();

    path.moveTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(0, size.height * 1.05);
    path.cubicTo(
      size.width * 0.68,
      size.height * 0.5875,
      size.width * 0.9465,
      size.height * 1.3875,
      size.width,
      size.height * 0.8,
    );
    path.lineTo(size.width, 0);
    path.close();

    Paint paintFill = Paint()..style = PaintingStyle.fill;
    paintFill.color = kPrimaryRed;
    canvas.drawPath(path, paintFill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CustomTopBar extends ConsumerWidget {
  final String title;

  const CustomTopBar({super.key, required this.title});

  void _showAuthPopup(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Connexion requise'),
            content: const Text(
              'Veillez vous connecter pour accéder à plus de fonctionnalité et commander vos plats.',
            ),
            actions: [
              // Bouton "Retourner explorer" - ferme simplement le popup
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Retourner explorer'),
              ),
              // Bouton "Se connecter" - ferme le popup ET navigue vers LoginPage
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: kPrimaryRed),
                onPressed: () {
                  // Fermer d'abord le popup
                  Navigator.of(context).pop();
                  // Puis naviguer vers la page de connexion
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: const Text(
                  'Se connecter',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Stack(
      children: [
        Positioned(
          left: 10,
          top: statusBarHeight + height * 0.008,
          child: Text(
            title,
            style: TextStyle(
              fontSize: width * 0.086,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          right: width * 0.025,
          top: statusBarHeight + height * 0.015,
          child: Row(
            children: [
              _buildIcon(context, "assets/images/order.svg"),
              const SizedBox(width: 6),
              _buildIcon(
                context,
                "assets/images/cart.svg",
                width * 0.06,
                width * 0.06,
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () async {
                  final secureStorage = ref.watch(secureStorageProvider);
                  final token = await secureStorage.read(key: 'authToken');

                  if (token != null && token.isNotEmpty) {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text('Déjà connecté'),
                            content: const Text(
                              'Vous êtes déjà connecté à votre compte.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Fermer'),
                              ),
                              TextButton(
                                onPressed: () {
                                  secureStorage.delete(key: 'authToken');
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Se deconnecter'),
                              ),
                            ],
                          ),
                    );
                  } else {
                    _showAuthPopup(context);
                  }
                },
                child: _buildIcon(context, "assets/images/user.svg"),
              ),
            ],
          ),
        ),
      ],
    );  
  }

  Widget _buildIcon(
    BuildContext context,
    String assetPath, [
    double? widthIcon,
    double? heightIcon,
  ]) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.088,
      height: width * 0.088,
      child: Container(
        decoration: BoxDecoration(color: kDarkGray, shape: BoxShape.circle),
        child: Center(
          child: SvgPicture.asset(
            assetPath,
            width: widthIcon ?? width * 0.05,
            height: heightIcon ?? width * 0.05,
          ),
        ),
      ),
    );
  }
}
