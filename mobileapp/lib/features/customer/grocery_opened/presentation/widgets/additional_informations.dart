import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/providers/grocery_opened_provider.dart';

class AdditionalInformations extends ConsumerWidget {
  final double width;
  const AdditionalInformations({super.key, required this.width});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final grocery = ref.watch(selectedGroceryProvider);

    final bool isDarkMode = ref.watch(darkModeProvider);
    final bgColor = isDarkMode ? kPrimaryDark : kSecondaryWhite;
    final textColor = isDarkMode ? kLightGray : kDarkGray;
    final iconsColor = kPrimaryRed;

    final double minFontSize = 10;
    final double maxFontSize = 12;
    final double iconsSize = width * 0.15;

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(
          5,
        ), // Ajuste cette valeur pour changer le rayon
      ),
      padding: EdgeInsets.all(10),

      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.fire_truck, color: iconsColor, size: iconsSize),
              SizedBox(width: 2),
              AutoSizeText(
                "${grocery?.delivPrice} DZD",
                style: TextStyle(color: textColor),
                maxLines: 1,
                minFontSize: minFontSize,
                maxFontSize: maxFontSize,
              ),
            ],
          ),

          Row(
            children: [
              Icon(Icons.lock_clock, color: iconsColor, size: iconsSize),
              SizedBox(width: 2),
              AutoSizeText(
                parseTime(grocery!.delivTime),
                style: TextStyle(color: textColor),
                maxLines: 1,
                minFontSize: minFontSize,
                maxFontSize: maxFontSize,
              ),
            ],
          ),

          Row(
            children: [
              Icon(Icons.star, color: iconsColor, size: iconsSize),
              SizedBox(width: 2),
              AutoSizeText(
                "${grocery.rating}",
                style: TextStyle(color: textColor, fontSize: 12),
                maxLines: 1,
                minFontSize: minFontSize,
                maxFontSize: maxFontSize,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
