import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/auth/presentation/providers/auth_provider.dart';

class MyPainter2 extends CustomPainter {
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

class DelivererProfilTopBar extends ConsumerWidget {
  final String title;

  const DelivererProfilTopBar({super.key, required this.title});

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
          child: GestureDetector(
            onTap: () async {
              final secureStorage = ref.watch(secureStorageProvider);
              final token = await secureStorage.read(key: 'authToken');
              Navigator.pop(context);

              // if (token != null && token.isNotEmpty) {
              //   showDialog(
              //     context: context,
              //     builder:
              //         (context) => AlertDialog(
              //           title: const Text('Déjà connecté'),
              //           content: const Text(
              //             'Vous êtes déjà connecté à votre compte.',
              //           ),
              //           actions: [
              //             TextButton(
              //               onPressed: () => Navigator.of(context).pop(),
              //               child: const Text('Fermer'),
              //             ),
              //           ],
              //         ),
              //   );
              // } else {
              //   _showAuthPopup(context);
              // }
            },
            child: _buildIcon(context),
          ),
        ),
      ],
    );
  }

  Widget _buildIcon(
    BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.088,
      height: width * 0.088,
      child: Container(
        decoration: BoxDecoration(color: kDarkGray, shape: BoxShape.circle),
        child: Center(
          child: Icon(
            Icons.logout_outlined,
            size: width * 0.06,
            color: kPrimaryWhite,
          ),
        ),
      ),
    );
  }
}
