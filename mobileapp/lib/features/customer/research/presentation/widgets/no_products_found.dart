import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';

class NoProductsFound extends ConsumerWidget {
  const NoProductsFound({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);

    final Color iconColor = isDarkMode ? kLightGray : kMediumGray;
    final Color textColor = isDarkMode ? kSecondaryWhite : kPrimaryBlack;
    final Color backgroundColor = isDarkMode ? kPrimaryDark : kSecondaryWhite;

    return Container(
      color: backgroundColor,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off_rounded, size: 60, color: iconColor),
            const SizedBox(height: 12),
            Text(
              "Aucun produit trouvé pour le moment :(",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
