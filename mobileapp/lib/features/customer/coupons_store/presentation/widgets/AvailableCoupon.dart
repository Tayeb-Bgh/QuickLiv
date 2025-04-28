import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';
import 'package:mobileapp/features/auth/presentation/providers/auth_provider.dart';
import 'package:mobileapp/features/customer/coupons_store/presentation/providers/Coupon_provider.dart';
import 'package:mobileapp/features/customer/coupons_store/presentation/providers/Point_provider.dart';
import 'package:mobileapp/features/customer/coupons_store/presentation/widgets/Frosted_Coupon.dart';

class Availablecoupon extends ConsumerWidget {
  const Availablecoupon({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pointsState = ref.watch(pointProvider);

    final size = MediaQuery.of(context).size;
    final isDarkMode = ref.watch(darkModeProvider);

    // Colors based on dark mode
    final backgroundColor = isDarkMode ? kSecondaryDark : kSecondaryWhite;
    final borderColor = isDarkMode ? kSecondaryDark : kLightGray;
    final textColor = isDarkMode ? kLightGray : kPrimaryBlack;

    final screenWidth = size.width;

    return Container(
      width: screenWidth * 0.92,
      height: 315,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor, width: 1.0),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          AutoSizeText(
            'Acheter des coupons',
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
            maxLines: 1,
            minFontSize: 1,
          ),

          SizedBox(height: 10),

          Column(
            children: [
              // Les deux petits coupons en haut
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Place réservée pour le coupon 30
                  Expanded(
                    child: _buildCouponCard(
                      context,
                      isDarkMode
                          ? 'assets/images/coupon_30_dark.svg'
                          : 'assets/images/coupon_30_light.svg',
                      pointsState.value ?? 0,
                      kRequiredPoints30,
                      size.height * 0.10,
                      ref,
                      false,
                      priceCoupon30,
                      30,
                      isDarkMode,
                    ),
                  ),
                  SizedBox(width: size.width * 0.03),
                  // Place réservée pour le coupon 60
                  Expanded(
                    child: _buildCouponCard(
                      context,
                      isDarkMode
                          ? 'assets/images/coupon_60_Dark.svg'
                          : 'assets/images/coupon_60_light.svg',
                      pointsState.value ?? 0,
                      kRequiredPoints60,
                      size.height * 0.10,
                      ref,
                      false,
                      priceCoupon60,
                      60,
                      isDarkMode,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.016),
              // Grand coupon en bas
              Center(
                child: _buildCouponCard(
                  context,
                  isDarkMode
                      ? 'assets/images/coupon_100_Dark.svg'
                      : 'assets/images/coupon_100_light.svg',
                  pointsState.value ?? 0,
                  kRequiredPoints100,
                  size.height * 0.147,
                  ref,
                  true,
                  priceCoupon100,
                  100,
                  isDarkMode,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildCouponCard(
    BuildContext context,
    String assetPath,
    int currentPoint,
    int requiredPoint,
    double height,
    WidgetRef ref,
    bool isLarge,
    double price,
    int discountRate,
    bool isDarkMode,
  ) {
    final tokenAsyncValue = ref.watch(jwtTokenProvider);
    final isAuthenticated = tokenAsyncValue.value != null;
    return Stack(
      children: [
        SvgPicture.asset(assetPath, fit: BoxFit.contain, height: height),

        if (currentPoint >= requiredPoint && isAuthenticated)
          FrostedCoupon(
            pointsText: requiredPoint,
            onPressed: () async {
              try {
                final couponNotifier = ref.read(couponProvider.notifier);
                final reductionCode = generateRandomCode(predefinedCodes);
                await couponNotifier.createCoupon(reductionCode, discountRate);

                final pointNotifier = ref.read(pointProvider.notifier);
                await pointNotifier.subtractPoints(requiredPoint);
                await pointNotifier.refreshPoints();
                couponNotifier.reloadCouponsFromStorage();
              } catch (e) {
                if (context.mounted) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Erreur'),
                        content: Text('Erreur lors de l\'achat du coupon.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              }
            },
            isLargeCoupon: isLarge,
          ),
      ],
    );
  }
}
