import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';

class GenderSelectionRow extends ConsumerWidget {
  final String? selectedValue;
  final ValueChanged<String> onValueSelected;

  const GenderSelectionRow({
    super.key,
    required this.selectedValue,
    required this.onValueSelected,
  });

  Widget buildValueOption(
    String gender,
    IconData icon,
    bool isSelected,
    Color iconColor,
    Color textColor,
  ) {
    Color effectiveTextColor =
        (gender == "Homme" || gender == "Femme")
            ? (textColor == kPrimaryWhite ? kPrimaryWhite : kPrimaryDark)
            : textColor;

    return GestureDetector(
      onTap: () => onValueSelected(gender),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: isSelected ? kPrimaryRed : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: kPrimaryRed, width: 2),
            ),
            child: Icon(icon, color: iconColor, size: 12),
          ),
          SizedBox(width: 6),
          Text(
            gender,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: effectiveTextColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);
    final Color textColor = isDarkMode ? kPrimaryWhite : kPrimaryDark;
    final Color iconColor = isDarkMode ? kPrimaryWhite : kPrimaryDark;

    return Row(
      children: [
        Text(
          "Sexe : ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: textColor,
          ),
        ),
        SizedBox(width: 5),
        Text(
          "*",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
            fontSize: 20,
          ),
        ),
        SizedBox(width: 10),
        buildValueOption(
          "Homme",
          Icons.male,
          selectedValue == "Homme",
          iconColor,
          textColor,
        ),
        SizedBox(width: 20),

        buildValueOption(
          "Femme",
          Icons.female,
          selectedValue == "Femme",
          iconColor,
          textColor,
        ),
      ],
    );
  }
}
