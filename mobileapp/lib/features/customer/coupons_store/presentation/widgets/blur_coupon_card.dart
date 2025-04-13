import 'dart:ui';
import 'package:flutter/material.dart';

class BlurCouponCard extends StatelessWidget {
  final String pointsText;
  final VoidCallback onPressed;

  const BlurCouponCard({
    super.key,
    required this.pointsText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            width: 250,
            height: 130,
            alignment: Alignment.center,
            color: Colors.black.withOpacity(0.5),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  pointsText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(
                          0.25,
                        ), // Couleur de l'ombre
                        offset: Offset(0, 4.0), // Décalage de l'ombre
                        blurRadius: 4, // Rayon de flou
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: onPressed,
                  child: Container(
                    width: 148,
                    height: 37,
                    decoration: BoxDecoration(
                      color: Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Acheter',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
