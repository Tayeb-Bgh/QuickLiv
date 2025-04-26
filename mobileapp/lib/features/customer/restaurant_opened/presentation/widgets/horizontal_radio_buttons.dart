import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';
import 'package:mobileapp/features/customer/restaurant_opened/presentation/providers/restaurant_opened_provider.dart' as restaurantOpenedProvider;


class HorizontalRadioButtons extends ConsumerWidget {
  final int idRestaurant;
  const HorizontalRadioButtons(this.idRestaurant, {super.key});

  IconData _getIconFromName(String name) {
    switch (name.toLowerCase()) {
      case 'kebabier':
        return Icons.store;
      case 'pizzeria':
        return Icons.local_pizza;
      case 'burguerie':
        return Icons.set_meal;
      case 'rôtisserie':
        return Icons.local_grocery_store;
      case 'pâtisserie':
        return Icons.breakfast_dining;
      case 'fast food':
        return Icons.fastfood;
      case 'restaurant':
        return Icons.lunch_dining;
      case 'grillades':
        return Icons.eco;
      default:
        return Icons.restaurant;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isDarkMode = ref.watch(darkModeProvider);
    final selected = ref.watch(restaurantOpenedProvider.selectedCategoryProvider);

    final asyncCategories = ref.watch(restaurantOpenedProvider.restaurantCategoriesProvider(idRestaurant));

    return asyncCategories.when(
      data: (categories) {
        return SizedBox(
          height: height * 0.039,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = selected == category;

              return GestureDetector(
                onTap: () {
                  /* final newSelection = isSelected ? null : category;
                  ref.read(selectedCategoryProvider.notifier).state = newSelection; */
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
                        _getIconFromName(category),
                        color: isSelected
                            ? kSecondaryWhite
                            : isDarkMode
                                ? kSecondaryWhite
                                : kPrimaryRed,
                        size: width * 0.05,
                      ),
                      SizedBox(width: width * 0.01),
                      Text(
                        capitalize(category),
                        style: TextStyle(
                          color: isSelected
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
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erreur: $e')),
    );
  }
}
