import 'package:flutter/material.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';

Future<void> showConfirmEmptyCartDialog(
  BuildContext context,
  ref, {
  required VoidCallback onConfirm,
}) async {
  await showDialog(
    context: context,
    builder: (context) {
      final width = MediaQuery.of(context).size.width;
      final bool isDarkMode = ref.watch(darkModeProvider);
      final backgroundColor = isDarkMode ? kPrimaryBlack : kPrimaryWhite;
      final fontColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;

      return AlertDialog(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: SizedBox(
          width: width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Vider le panier",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Êtes-vous sûr de vouloir vider le panier ? Cette action est irréversible.",
                textAlign: TextAlign.center,
                style: TextStyle(color: fontColor, fontSize: 16),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    iconSize: width * 0.1,
                    icon: Icon(
                      Icons.close,
                      color: isDarkMode ? kLightGray : kDarkGray,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Container(
                    color: backgroundColor,
                    child: IconButton(
                      iconSize: width * 0.1,
                      icon: Icon(Icons.check_circle, color: kPrimaryRed),
                      onPressed: () {
                        onConfirm();
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Panier vidé avec succès."),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
