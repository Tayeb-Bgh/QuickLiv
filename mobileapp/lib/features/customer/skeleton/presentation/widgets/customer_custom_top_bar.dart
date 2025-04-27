import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobileapp/features/auth/presentation/pages/login_page.dart';
import 'package:mobileapp/features/auth/presentation/providers/auth_provider.dart';
import 'package:mobileapp/features/customer/profile/presentation/pages/profile_popup_page.dart';
import 'package:mobileapp/features/customer/profile/presentation/widgets/profile_popup.dart';

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
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Connexion requise',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AutoSizeText(
                    'Veuillez vous connecter pour accéder\nplus de fonctionnalité et commander\nvos plats.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.grey[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(
                            'Retourner explorer',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryRed,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Se connecter',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
                    showProfilePopupPage(context);
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
