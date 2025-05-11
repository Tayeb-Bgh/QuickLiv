import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';

class DeliveryStateWidget extends ConsumerWidget {
  final bool state;
  const DeliveryStateWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);
    final Color textColor = isDarkMode ? kSecondaryWhite : kPrimaryBlack;

    return Row(
      children: [
        ClipOval(
          child: Container(
            color: kPrimaryRed, // background color of the circle
            width: 40,
            height: 40,
            child: Icon(Icons.delivery_dining, color: kPrimaryWhite, size: 30),
          ),
        ),
        SizedBox(width: 5),
        Column(
          children: [
            AutoSizeText(
              "Livraison",
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              maxLines: 1,
              maxFontSize: 13,
              minFontSize: 11,
            ),
            AutoSizeText(
              state ? "Disponible" : "Indisponible",
              style: TextStyle(color: kPrimaryRed, fontWeight: FontWeight.bold),
              maxLines: 1,
              maxFontSize: 10,
              minFontSize: 9,
            ),
          ],
        ),
      ],
    );
  }
}
