import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/providers/grocery_opened_provider.dart';

class SocialMediasButtons extends ConsumerWidget {
  final double width;
  final VoidCallback onClickPhone;
  final VoidCallback onClickFcb;
  final VoidCallback onClickInsta;
  const SocialMediasButtons({
    super.key,
    required this.width,
    required this.onClickFcb,
    required this.onClickInsta,
    required this.onClickPhone,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);
    final Color bgColor = isDarkMode ? kPrimaryDark : kSecondaryWhite;
    final Color iconsColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    final double iconsSize = width * 0.15;
    final groc = ref.watch(selectedGroceryProvider);

    return Container(
      margin: EdgeInsets.only(top: 10),
      width: width,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(
          15,
        ), // Ajuste cette valeur pour changer le rayon
      ),
      padding: EdgeInsets.all(1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              onClickPhone();
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(iconsSize, iconsSize),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.center,
            ),
            child: Icon(Icons.phone, color: iconsColor, size: iconsSize),
          ),
          TextButton(
            onPressed: () {
              onClickFcb();
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(iconsSize + 5, iconsSize + 5),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.center,
            ),
            child: Icon(Icons.facebook, color: iconsColor, size: iconsSize),
          ),
          TextButton(
            onPressed: () {
              onClickInsta();
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(iconsSize + 5, iconsSize + 5),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.center,
            ),
            child: Icon(Icons.photo, color: iconsColor, size: iconsSize),
          ),
        ],
      ),
    );
  }
}
