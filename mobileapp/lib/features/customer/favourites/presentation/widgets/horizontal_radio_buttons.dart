import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/favourites/presentation/providers/favourites_provider.dart';

class HorizontalRadioButtons extends ConsumerWidget {
  const HorizontalRadioButtons({super.key});

  void _showFilterDialog(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedTypeProvider);
    final isDarkMode = ref.watch(darkModeProvider);
    final categories = [
      {'label': 'Kebabiers', 'type': 'kebabier', 'icon': Icons.kebab_dining},
      {'label': 'Burgueries', 'type': 'burguerie', 'icon': Icons.lunch_dining},
      {'label': 'Fast food', 'type': 'fast food', 'icon': Icons.fastfood},
      {'label': 'Grillades', 'type': 'grillades', 'icon': Icons.outdoor_grill},
      {'label': 'Rôtisseries', 'type': 'rôtisserie', 'icon': Icons.set_meal},
      {'label': 'Pâtisseries', 'type': 'pâtisserie', 'icon': Icons.cake},
      {'label': 'Pizzeria', 'type': 'pizzeria', 'icon': Icons.local_pizza},
      {'label': 'Restaurants', 'type': 'restaurant', 'icon': Icons.restaurant},
      {'label': 'Superéttes', 'type': 'supérette', 'icon': Icons.store},
      {
        'label': 'Supermarchés',
        'type': 'supermarché',
        'icon': Icons.shopping_cart,
      },
      {'label': 'Boucheries', 'type': 'boucherie', 'icon': Icons.set_meal},
      {
        'label': "Fruits & Légumes",
        'type': 'fruits & légumes',
        'icon': Icons.eco,
      },
      {
        'label': "Boulangeries",
        'type': 'boulangerie',
        'icon': Icons.breakfast_dining,
      },
      {
        'label': "Poissonneries",
        'type': 'poissonnerie',
        'icon': Icons.set_meal_outlined,
      },
      {'label': "Fromageries", 'type': 'fromagerie', 'icon': Icons.icecream},
      {'label': "Épices", 'type': 'magasin d\'épices', 'icon': Icons.spa},
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
                  print('Dialog comparing: $selected == ${category['type']}');

                  final isSelected = selected == category['type'];

                  return RadioListTile<String>(
                    title: Row(
                      children: [
                        Icon(category['icon'] as IconData, color: kPrimaryRed),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            category['label'] as String,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                    value: category['type'] as String,
                    groupValue: selected,
                    onChanged: (value) {
                      ref.read(selectedTypeProvider.notifier).state = value;
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
                  ref.read(selectedTypeProvider.notifier).state = null;
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
    final isDarkMode = ref.watch(darkModeProvider);

    final selected = ref.watch(selectedTypeProvider);
    final categories = [
      {'label': 'Pizzerias', 'type': 'pizzeria', 'icon': Icons.local_pizza},
      {'label': 'Restaurants', 'type': 'restaurant', 'icon': Icons.restaurant},
      {'label': 'Superéttes', 'type': 'supérette', 'icon': Icons.store},
      {
        'label': 'Supermarchés',
        'type': 'supermarché',
        'icon': Icons.shopping_cart,
      },
      {'label': 'Boucheries', 'type': 'boucherie', 'icon': Icons.set_meal},
      {
        'label': "Fruits & Légumes",
        'type': 'fruits & légumes',
        'icon': Icons.eco,
      },
      {
        'label': "Boulangerie",
        'type': 'boulangerie',
        'icon': Icons.breakfast_dining,
      },
      {
        'label': "Poissonnerie",
        'type': 'poissonnerie',
        'icon': Icons.set_meal_outlined,
      },
      {'label': "Fromagerie", 'type': 'fromagerie', 'icon': Icons.icecream},
      {'label': "Épices", 'type': 'magasin d\'épices', 'icon': Icons.spa},
    ];

    return SizedBox(
      height: height * 0.039,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
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
                  size: 20,
                ),
              ),
            );
          }

          // Les autres éléments normaux
          final category = categories[index - 1];
          final isSelected = selected == category['type'];

          return GestureDetector(
            onTap: () {
              final selected = isSelected ? null : category['type'] as String;

              ref.read(selectedTypeProvider.notifier).state = selected;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
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
                    size: 20,
                  ),
                  const SizedBox(width: 8),
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
