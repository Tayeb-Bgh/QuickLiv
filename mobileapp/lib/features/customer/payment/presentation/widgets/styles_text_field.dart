import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';

class StylesTextField extends ConsumerWidget {
  const StylesTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);

    final Color inputTxtColor = isDarkMode ? kSecondaryWhite : kPrimaryDark;
    final Color hintColor = isDarkMode ? kLightGray : kMediumGray;

    return SizedBox(
      height: 35,
      child: TextField(
        cursorColor: kPrimaryRed,
        decoration: InputDecoration(
          hintText: 'Votre code', // Texte d'exemple
          hintStyle: TextStyle(
            color: hintColor, // Couleur du texte d'exemple
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
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20,
          ), // Padding interne
        ),
        maxLines: 1,
        keyboardType: TextInputType.text, // Type de clavier
        style: TextStyle(
          color: inputTxtColor, // Couleur du texte
          fontSize: 16, // Taille de la police
        ),
      ),
    );
  }
}
