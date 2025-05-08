import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/providers/grocery_opened_provider.dart';

class FiltersRadioButtons extends ConsumerWidget {
  final List<String> categories;
  const FiltersRadioButtons({super.key, required this.categories});

  void _showFilterDialog(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedSecondCategoryProvider);
    final isDarkMode = ref.watch(darkModeProvider);

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

                  return RadioListTile<String>(
                    title: Text(category),
                    value: category,
                    groupValue: selected,
                    onChanged: (value) {
                      ref.read(selectedSecondCategoryProvider.notifier).state =
                          value;
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
                  ref.read(selectedSecondCategoryProvider.notifier).state =
                      null;
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

    final selected = ref.watch(selectedSecondCategoryProvider);

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
          final isSelected = selected == category;

          return GestureDetector(
            onTap: () {
              final selected = isSelected ? null : category;
              ref.read(selectedSecondCategoryProvider.notifier).state =
                  selected;
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
                  Text(
                    category,
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
