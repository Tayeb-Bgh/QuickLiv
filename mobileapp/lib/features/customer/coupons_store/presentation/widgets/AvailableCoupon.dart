import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';
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

    final backgroundColor = isDarkMode ? kSecondaryDark : kSecondaryWhite;
    final borderColor = isDarkMode ? kSecondaryDark : kLightGray;
    final textColor = isDarkMode ? kLightGray : kPrimaryBlack;

    final screenWidth = size.width;

    return Container(
      width: screenWidth * 0.92,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                      ref.watch(isActiveCoupon30),
                      isActiveCoupon30,
                      loadingCoupon30Provider,
                    ),
                  ),
                  SizedBox(width: size.width * 0.03),

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
                      ref.watch(isActiveCoupon60),
                      isActiveCoupon60,
                      loadingCoupon60Provider,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.016),

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
                  ref.watch(isActiveCoupon100),
                  isActiveCoupon100,
                  loadingCoupon100Provider,
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
    bool isActive,
    StateProvider<bool> availableProvier,
    StateProvider<bool> loadingProvider,
  ) {
    final width = MediaQuery.of(context).size.width;
    final littleCouponWidth = width * 0.4;
    final bigCouponWidth = width * 0.8;
    final isLoading = ref.watch(loadingProvider);

    return GestureDetector(
      onTap: () {
        ref.read(availableProvier.notifier).state =
            !ref.watch(availableProvier);
      },
      child: Stack(
        children: [
          SvgPicture.asset(
            assetPath,
            width: isLarge ? bigCouponWidth : littleCouponWidth,
          ),

          FrostedCoupon(
            isActive: isActive,
            pointsText: requiredPoint,
            isLoading: isLoading,
            onPressed: () async {
              ref.read(loadingProvider.notifier).state = true;

              try {
                final couponNotifier = ref.read(couponProvider.notifier);
                final reductionCode = generateRandomCode(predefinedCodes);
                await couponNotifier.createCoupon(reductionCode, discountRate);
                ref.read(couponProvider.notifier).fetchCoupons();
                final pointNotifier = ref.read(pointProvider.notifier);
                await pointNotifier.subtractPoints(requiredPoint);
                await pointNotifier.refreshPoints();
                couponNotifier.reloadCouponsFromStorage();

                ref.read(loadingProvider.notifier).state = false;

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Achat du coupon réussi !'),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              } catch (e) {
                ref.read(loadingProvider.notifier).state = false;

                if (currentPoint < requiredPoint) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Vous ne posséder pas assez du points '),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              }
            },
            isLargeCoupon: isLarge,
          ),
        ],
      ),
    );
  }
}
