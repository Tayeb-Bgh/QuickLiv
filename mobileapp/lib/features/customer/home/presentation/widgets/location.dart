import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';

class Location extends ConsumerWidget {
  const Location({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDarkMode = ref.watch(darkModeProvider);
    final backgroundColor = isDarkMode ? kPrimaryDark : kSecondaryWhite;
    final fontColor1 = isDarkMode ? kSecondaryWhite : kPrimaryRed;
    final fontColor2 = isDarkMode ? kLightGray : kPrimaryBlack;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: kLightGray),
        boxShadow: [
          BoxShadow(
            color: kPrimaryBlur,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.location_pin, color: kPrimaryRed),
          const SizedBox(width: 6),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  'Village Agricole, Sidi Aich, Bejaia',
                  maxLines: 2,
                  minFontSize: 9,
                  maxFontSize: 12,
                  style: TextStyle(color: fontColor1),
                ),
                const SizedBox(height: 2), // petit espace entre les lignes
                AutoSizeText(
                  '48° 51\' 24" N, 2° 21\' 8" E',
                  maxLines: 1,

                  minFontSize: 8,
                  maxFontSize: 11,
                  style: TextStyle(color: fontColor2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
