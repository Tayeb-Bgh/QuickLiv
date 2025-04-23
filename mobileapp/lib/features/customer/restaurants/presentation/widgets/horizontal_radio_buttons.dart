import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/restaurants/presentation/providers/restaurants_provider.dart';

class HorizontalRadioButtons extends ConsumerWidget {
  const HorizontalRadioButtons({super.key});

  void _showFilterDialog(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedCategoryProvider);
    final isDarkMode = ref.watch(darkModeProvider);
    final categories = [
      {'label': 'Kebabier', 'icon': Icons.store},
      {'label': "Pizzeria", 'icon': Icons.store},
      {'label': 'Burguerie', 'icon': Icons.set_meal},
      {'label': "Rôtisserie", 'icon': Icons.local_grocery_store},
      {'label': "Pâtisserie", 'icon': Icons.breakfast_dining},
      {'label': "Fast food", 'icon': Icons.set_meal},
      {'label': "Restaurant", 'icon': Icons.lunch_dining},
      {'label': "Grillades", 'icon': Icons.eco},
    ];

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Choisir un filtre'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selected == category['label'];
                  final widht = MediaQuery.of(context).size.width;

                  return RadioListTile<String>(
                    title: Row(
                      children: [
                        Icon(category['icon'] as IconData, color: kPrimaryRed),
                        SizedBox(width: 8),
                        Text(category['label'] as String),
                      ],
                    ),
                    value: category['label'] as String,
                    groupValue: selected,
                    onChanged: (value) {
                      ref.read(selectedCategoryProvider.notifier).state = value;
                      Navigator.pop(context);
                    },
                    activeColor: kPrimaryRed,
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  ref.read(selectedCategoryProvider.notifier).state = null;
                  Navigator.pop(context);
                },
                child: const Text('Réinitialiser'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Fermer'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isDarkMode = ref.watch(darkModeProvider);

    final selected = ref.watch(selectedCategoryProvider);
    final categories = [
      {'label': 'Kebabier', 'icon': Icons.store},
      {'label': "Pizzeria", 'icon': Icons.store},
      {'label': 'Burguerie', 'icon': Icons.set_meal},
      {'label': "Rôtisserie", 'icon': Icons.local_grocery_store},
      {'label': "Pâtisserie", 'icon': Icons.breakfast_dining},
      {'label': "Fast food", 'icon': Icons.set_meal},
      {'label': "Restaurant", 'icon': Icons.lunch_dining},
      {'label': "Grillades", 'icon': Icons.eco},
    ];

    return SizedBox(
      height: height * 0.039,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: width * kDefaultPadding),
        itemCount: categories.length + 1, // +1 pour le bouton settings
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          // Premier élément = bouton settings
          if (index == 0) {
            return GestureDetector(
              onTap: () => _showFilterDialog(context, ref),
              child: Container(
                width:
                    height * 0.039, // Carré de la même hauteur que les autres
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: kPrimaryRed, width: 2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.settings,
                  color: isDarkMode ? kWhiteGray : kPrimaryRed,
                  size: width * 0.058,
                ),
              ),
            );
          }

          // Les autres éléments normaux
          final category = categories[index - 1];
          final isSelected = selected == category['label'];

          return GestureDetector(
            onTap: () {
              final selected = isSelected ? null : category['label'] as String;
              ref.read(selectedCategoryProvider.notifier).state = selected;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.03,
                vertical: height * 0.005,
              ),
              decoration: BoxDecoration(
                color: isSelected ? kPrimaryRed : Colors.transparent,
                border: Border.all(color: kPrimaryRed, width: 2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(
                    category['icon'] as IconData,
                    color:
                        isSelected
                            ? kSecondaryWhite
                            : isDarkMode
                            ? kSecondaryWhite
                            : kPrimaryRed,
                    size: width * 0.05,
                  ),
                  SizedBox(width: width * 0.01),
                  Text(
                    category['label'] as String,
                    style: TextStyle(
                      color:
                          isSelected
                              ? kSecondaryWhite
                              : isDarkMode
                              ? kSecondaryWhite
                              : kPrimaryRed,
                      fontWeight: FontWeight.bold,
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
