import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/constants.dart';

class FrostedCoupon extends StatelessWidget {
  final int pointsText;
  final VoidCallback onPressed;
  final bool isLargeCoupon;

  const FrostedCoupon({
    super.key,
    required this.pointsText,
    required this.onPressed,
    required this.isLargeCoupon,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Positioned(
      top: size.height * (isLargeCoupon ? 0.012 : 0.0076),
      bottom: size.height * (isLargeCoupon ? 0.01 : 0.0075),
      left: size.width * (isLargeCoupon ? 0.050 : 0.03),
      right: size.width * (isLargeCoupon ? 0.050 : 0.04),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            width: size.width * (isLargeCoupon ? 0.6 : 0.35),
            height: size.height * (isLargeCoupon ? 0.14 : 0.09),
            color: kPrimaryBlur,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  "$pointsText Points",
                  maxLines: 1,
                  minFontSize: 1,
                  style: TextStyle(
                    color: kPrimaryWhite,
                    fontSize: isLargeCoupon ? 40.0 : 20.0,
                    fontWeight: FontWeight.w800,
                    shadows: [
                      Shadow(
                        color: kPrimaryBlack.withOpacity(0.25),
                        offset: const Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.013),
                GestureDetector(
                  onTap: onPressed,
                  child: Container(
                    width:
                        isLargeCoupon
                            ? size.width *
                                0.36 // ~148px pour 412px de largeur
                            : size.width * 0.18, // ~74px pour 412px de largeur
                    height: size.height * (isLargeCoupon ? 0.035 : 0.025),
                    decoration: BoxDecoration(
                      color: kPrimaryBlack,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: AutoSizeText(
                        'Acheter',
                        maxLines: 1,
                        minFontSize: 1,
                        style: TextStyle(
                          color: kPrimaryWhite,
                          fontSize: isLargeCoupon ? 20 : 10,
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
