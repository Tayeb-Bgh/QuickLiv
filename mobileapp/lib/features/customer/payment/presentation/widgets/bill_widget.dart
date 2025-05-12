import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';

class BillWidget extends ConsumerWidget {
  final double totalProd;
  final double totalDeliv;
  final double totalReduc;
  final double total;
  const BillWidget({
    super.key,
    required this.total,
    required this.totalProd,
    required this.totalDeliv,
    required this.totalReduc,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);
    final Color sectionTxtColor = isDarkMode ? kLightGray : kMediumGray;
    final Color textColor1 = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    final Color textColor2 = isDarkMode ? kSecondaryWhite : kPrimaryDark;
    final Color totalColor = kPrimaryRed;
    final Color reducColor = kPrimaryGreen;

    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Text(
          "Facture",
          style: TextStyle(
            color: sectionTxtColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Container(
          width: width,
          height: 5,
          decoration: BoxDecoration(
            color: sectionTxtColor,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Produits",
              style: TextStyle(color: textColor1, fontWeight: FontWeight.bold),
            ),
            Text(
              "${totalProd.toStringAsFixed(2)} DZD",
              style: TextStyle(color: textColor1, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Livraison",
              style: TextStyle(color: textColor2, fontSize: 12),
            ),
            Text(
              "${totalDeliv.toStringAsFixed(2)} DZD",
              style: TextStyle(color: textColor1, fontSize: 12),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Réduction",
              style: TextStyle(color: textColor2, fontSize: 12),
            ),
            Text(
              "-${totalReduc.toStringAsFixed(2)} DZD",
              style: TextStyle(color: reducColor, fontSize: 12),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total net",
              style: TextStyle(color: textColor1, fontWeight: FontWeight.bold),
            ),
            Text(
              "${total.toStringAsFixed(2)} DZD",
              style: TextStyle(color: totalColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
