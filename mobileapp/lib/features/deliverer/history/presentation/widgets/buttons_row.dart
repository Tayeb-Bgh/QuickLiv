import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/deliverer/history/presentation/providers/filter_provider.dart'; // Changement ici

class HorizontalRadioButtons extends ConsumerWidget {
  const HorizontalRadioButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedFilterProvider);
    final double screenHeight = MediaQuery.of(context).size.height;
    final isDarkMode = ref.watch(darkModeProvider);

    final backgroundColor = isDarkMode ? kPrimaryDark : Colors.white;
    final textColor = isDarkMode ? kPrimaryWhite : Colors.black;
    final shadowColor =
        isDarkMode
            ? Colors.black.withOpacity(0.5)
            : Colors.black.withOpacity(0.25);
    final borderColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;

    final categories = [
      {'label': 'Toutes'},
      {'label': "Livrées"},
      {'label': 'Annulées'},
    ];

    return SizedBox(
      height: screenHeight * 0.065,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selected == category['label'];

          return GestureDetector(
            onTap: () {
              if (!isSelected) {
                ref.read(selectedFilterProvider.notifier).state =
                    category['label'] as String;
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? kPrimaryRed : Colors.transparent,
                border: Border.all(color: kPrimaryRed, width: 2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Text(
                    category['label'] as String,
                    style: TextStyle(
                      color: isSelected ? kPrimaryWhite : kPrimaryRed,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
