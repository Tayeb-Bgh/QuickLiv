import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';
import 'package:mobileapp/features/customer/coupons_store/presentation/providers/Point_provider.dart';

class MyPoints extends ConsumerWidget {
  const MyPoints({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pointsState = ref.watch(pointProvider);
    final size = MediaQuery.of(context).size;
    final isDarkMode = ref.watch(darkModeProvider);

    final int points = pointsState.value ?? 0;

    final backgroundColor = isDarkMode ? kSecondaryDark : kSecondaryWhite;
    final borderColor = isDarkMode ? kSecondaryDark : kSecondaryWhite;
    final textColor = isDarkMode ? kLightGray : kPrimaryBlack;
    final progressBackgroundColor = isDarkMode ? kDarkGray : kRegularGray;
    final numberPointsColor = isDarkMode ? kLightGray : kSecondaryWhite;
    final infoBackgroundColor =
        isDarkMode
            ? kPrimaryRed.withOpacity(0.3)
            : kPrimaryRed.withOpacity(0.40);

    return Center(
      child: Container(
        width: size.width * 0.92,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: kPrimaryBlack.withOpacity(0.25),
              offset: const Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  'Mes Points',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 1,
                  minFontSize: 1,
                ),
                Container(
                  width: size.width * 0.25,
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.04,
                    vertical: size.height * 0.008,
                  ),
                  decoration: BoxDecoration(
                    color: kPrimaryRed,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: AutoSizeText(
                    "$points pts",
                    style: TextStyle(
                      color: numberPointsColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                    minFontSize: 1,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.01),
            const AutoSizeText(
              "Accumulez des points pour débloquer des coupons de réductions",
              style: TextStyle(
                fontSize: 15,
                color: kPrimaryRed,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              minFontSize: 1,
            ),
            SizedBox(height: size.height * 0.018),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: calculateProgress(points)),
              duration: const Duration(milliseconds: 800),
              builder: (context, value, child) {
                final color = Color.lerp(kPrimaryRed, kPrimaryGreen, value);
                return ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: LinearProgressIndicator(
                    value: value,
                    backgroundColor: progressBackgroundColor,
                    valueColor: AlwaysStoppedAnimation<Color>(color!),
                    minHeight: 13,
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: size.height * 0.004,
                top: size.height * 0.005,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    "0",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                    minFontSize: 12,
                  ),
                  AutoSizeText(
                    "500",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                    minFontSize: 12,
                  ),
                  AutoSizeText(
                    "1000",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                    minFontSize: 12,
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.018),
            Center(
              child: Container(
                width: size.width * 0.75,
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03,
                  vertical: size.height * 0.008,
                ),
                decoration: BoxDecoration(
                  color: infoBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: AutoSizeText(
                    "Plus que ${remainingPointsForMilestone(pointsState.value ?? 0)} points pour débloquer un coupon de 100%",
                    style: const TextStyle(
                      fontSize: 12,
                      color: kPrimaryRed,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    minFontSize: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
