import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/providers/grocery_opened_provider.dart';

class MainInformations extends ConsumerWidget {
  final double width;
  const MainInformations({super.key, required this.width});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final grocery = ref.watch(selectedGroceryProvider);

    final bool isDarkMode = ref.watch(darkModeProvider);
    final Color titleColor = isDarkMode ? kPrimaryWhite : kSecondaryWhite;
    final Color descColor = isDarkMode ? kLightGray : kLightGray;

    final double titleMinSize = 12;
    final double titleMaxSize = 14;
    final double descMinSize = 10;
    final double descMaxSize = 12;

    return SizedBox(
      width: width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                100,
              ), // Optionally, round the corners
              border: Border.all(
                color: Colors.white, // White border color
                width: 3, // Border width
              ),
            ),
            margin: EdgeInsets.only(right: 5),
            child: ClipOval(
              
              child: Image.network(
                grocery!.imgUrl,
                width: width * 0.38,
                height: width * 0.38,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Utilisation d'Expanded pour permettre au texte de s'étendre
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  grocery.name,
                  maxLines: 2,
                  minFontSize: titleMinSize,
                  maxFontSize: titleMaxSize,
                  style: TextStyle(
                    color: titleColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AutoSizeText(
                  grocery.description,
                  maxLines: 3,
                  minFontSize: descMinSize,
                  maxFontSize: descMaxSize,
                  style: TextStyle(color: descColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
