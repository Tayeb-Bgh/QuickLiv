import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';

class IconTextField extends ConsumerWidget {
  final IconData prefixIcon;
  final String label;
  const IconTextField({
    super.key,
    required this.prefixIcon,
    required this.label,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);

    final Color inputTxtColor = isDarkMode ? kSecondaryWhite : kPrimaryDark;
    final Color hintColor = isDarkMode ? kLightGray : kMediumGray;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label:",
          style: TextStyle(
            color: inputTxtColor,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 5),
        Container(
          margin: EdgeInsets.only(bottom: 5),
          height: 35,
          child: TextField(
            cursorColor: kPrimaryRed,
            decoration: InputDecoration(
              prefixIcon: SizedBox(
                width: 0,
                height: 10,
                child: Icon(prefixIcon, color: inputTxtColor),
              ),

              fillColor: kPrimaryDark, // Couleur de fond du champ de texte
              filled: true, // Activer le remplissage (fond coloré)

              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      Colors
                          .transparent, // Couleur du bord quand le champ est sélectionné
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      Colors
                          .transparent, // Couleur du bord quand il n'est pas sélectionné
                ),
              ),
              contentPadding: EdgeInsets.only(right: 10), // Padding interne
            ),
            maxLines: 1,
            keyboardType: TextInputType.text, // Type de clavier
            style: TextStyle(
              color: inputTxtColor, // Couleur du texte
              fontSize: 12, // Taille de la police
            ),
          ),
        ),
      ],
    );
  }
}
