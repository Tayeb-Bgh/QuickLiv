import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/constants.dart';

class FrostedCoupon extends StatelessWidget {
  final int pointsText;
  final VoidCallback onPressed;
  final bool isLargeCoupon;
  final bool isActive;
  final bool isLoading;

  const FrostedCoupon({
    super.key,
    required this.pointsText,
    required this.onPressed,
    required this.isLargeCoupon,
    required this.isActive,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final littleCouponWidth = width * 0.4;
    final bigCouponWidth = width * 0.8;

    return isActive
        ? Positioned(
          left:
              isLargeCoupon ? bigCouponWidth * 0.08 : littleCouponWidth * 0.08,
          right:
              isLargeCoupon ? bigCouponWidth * 0.09 : littleCouponWidth * 0.11,
          bottom: height * (isLargeCoupon ? 0.015 : 0.008),
          top: height * (isLargeCoupon ? 0.015 : 0.008),

          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(
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
                    SizedBox(height: height * 0.013),
                    GestureDetector(
                      onTap: isLoading ? null : onPressed,
                      child: Container(
                        width: isLargeCoupon ? width * 0.36 : width * 0.18,
                        height: height * (isLargeCoupon ? 0.035 : 0.025),
                        decoration: BoxDecoration(
                          color: kPrimaryBlack,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child:
                              isLoading
                                  ? SizedBox(
                                    width: isLargeCoupon ? 20 : 12,
                                    height: isLargeCoupon ? 20 : 12,
                                    child: CircularProgressIndicator(
                                      strokeWidth: isLargeCoupon ? 2.0 : 1.5,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        kPrimaryWhite,
                                      ),
                                    ),
                                  )
                                  : AutoSizeText(
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
        )
        : SizedBox();
  }
}
