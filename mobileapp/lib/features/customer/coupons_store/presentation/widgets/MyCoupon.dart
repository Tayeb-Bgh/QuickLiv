import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/coupons_store/presentation/providers/Coupon_provider.dart';

class MyCoupon extends ConsumerWidget {
  const MyCoupon({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coupons = ref.watch(couponProvider).coupons;
    final size = MediaQuery.of(context).size;
    final isDarkMode = ref.watch(darkModeProvider);

    // Colors based on dark mode
    final backgroundColor = isDarkMode ? kSecondaryDark : kSecondaryWhite;
    final borderColor = isDarkMode ? kSecondaryDark : kSecondaryWhite;
    final textColor = isDarkMode ? kLightGray : kPrimaryBlack;
    final emptyTextColor = isDarkMode ? kLightGray : Colors.grey;

    final codeBorderColor = isDarkMode ? kSecondaryDark : kPrimaryBlack;
    final codeTextColor = isDarkMode ? kSecondaryDark : kPrimaryBlack;

    return Container(
      width: size.width * 0.92,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor, width: 1.0),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: kPrimaryBlack.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeText(
            'Mes Coupons',
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
            maxLines: 1,
            minFontSize: 1,
          ),
          SizedBox(height: size.height * 0.01),
          SizedBox(
            height: size.height * 0.18,
            child:
                coupons.isEmpty
                    ? Center(
                      child: AutoSizeText(
                        "Aucun coupon disponible pour le moment.",
                        style: TextStyle(color: emptyTextColor),
                        maxLines: 1,
                        minFontSize: 1,
                      ),
                    )
                    : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      itemCount: coupons.length,
                      itemBuilder: (context, index) {
                        final coupon = coupons[index];
                        final discount = coupon.discountRate;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: size.height * 0.12,
                              width: size.width * 0.45,
                              child: Builder(
                                builder: (context) {
                                  if (discount == 30) {
                                    return SvgPicture.asset(
                                      'assets/images/Coupon_30.svg',
                                      fit: BoxFit.contain,
                                    );
                                  } else if (discount == 60) {
                                    return SvgPicture.asset(
                                      'assets/images/Coupon_60.svg',
                                      fit: BoxFit.contain,
                                    );
                                  } else if (discount == 100) {
                                    return SvgPicture.asset(
                                      'assets/images/Coupon_100.svg',
                                      fit: BoxFit.contain,
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: size.height * 0.005),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02,
                                vertical: size.height * 0.005,
                              ),
                              decoration: BoxDecoration(
                                color: kPrimaryWhite,
                                border: Border.all(
                                  color: codeBorderColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),

                              child: Center(
                                child: AutoSizeText(
                                  coupon.reductionCode ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: codeTextColor,
                                  ),
                                  minFontSize: 1,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder:
                          (context, index) =>
                              SizedBox(width: size.width * 0.05),
                    ),
          ),
        ],
      ),
    );
  }
}
