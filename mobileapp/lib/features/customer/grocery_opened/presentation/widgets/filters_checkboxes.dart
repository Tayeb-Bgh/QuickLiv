import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/providers/grocery_opened_provider.dart';

class FiltersCheckboxButtons extends ConsumerWidget {
  const FiltersCheckboxButtons({super.key});

  void _showFilterDialog(BuildContext context, WidgetRef ref) async {
    final isDarkMode = ref.watch(darkModeProvider);
    final categories = await ref.watch(categoriesProvider.future);
    final secondCategoriesMap = await ref.watch(
      secondCateogriesMapProvider.future,
    );

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            // 🛠️ Move ref.watch INSIDE the builder!
            final selectedCategories = ref.watch(selectedCategoriesProvider);
            final selectedSecondCategories = ref.watch(
              selectedSecondCategoriesProvider,
            );

            return AlertDialog(
              title: const Text('Choisir des filtres'),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final secondCategories =
                        secondCategoriesMap[category] ?? [];
                    final isChecked = selectedCategories.contains(category);

                    return CheckboxListTile(
                      title: Text(category),
                      value: isChecked,
                      onChanged: (checked) {
                        final categoriesNotifier = ref.read(
                          selectedCategoriesProvider.notifier,
                        );
                        final secondCategoriesNotifier = ref.read(
                          selectedSecondCategoriesProvider.notifier,
                        );

                        final updatedCategories = [...selectedCategories];
                        final updatedSecondCategories = [
                          ...selectedSecondCategories,
                        ];

                        if (checked == true &&
                            !updatedCategories.contains(category)) {
                          updatedCategories.add(category);
                          for (var secCat in secondCategories) {
                            if (!updatedSecondCategories.contains(secCat)) {
                              updatedSecondCategories.add(secCat);
                            }
                          }
                        } else if (checked == false &&
                            updatedCategories.contains(category)) {
                          updatedCategories.remove(category);
                          for (var secCat in secondCategories) {
                            updatedSecondCategories.remove(secCat);
                          }
                        }

                        categoriesNotifier.state = updatedCategories;
                        secondCategoriesNotifier.state =
                            updatedSecondCategories;

                        print(updatedCategories);
                        print(updatedSecondCategories);

                        setState(() {});
                      },
                      activeColor: kPrimaryRed,
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    ref.read(selectedCategoriesProvider.notifier).state = [];
                    ref.read(selectedSecondCategoriesProvider.notifier).state =
                        [];
                    Navigator.pop(context);
                  },
                  child: const Text('Réinitialiser'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Fermer'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final selectedCategories = ref.watch(selectedCategoriesProvider);
    final selectedSecondCategories = ref.watch(
      selectedSecondCategoriesProvider,
    );
    final isDarkMode = ref.watch(darkModeProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final secondCategoriesMap = ref.watch(secondCateogriesMapProvider);

    return categoriesAsync.when(
      data: (categories) {
        return SizedBox(
          height: height * 0.039,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: width * kDefaultPadding),
            itemCount: categories.length + 1,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              if (index == 0) {
                return GestureDetector(
                  onTap: () => _showFilterDialog(context, ref),
                  child: Container(
                    width: height * 0.039,
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

              final category = categories[index - 1];
              final isSelected = selectedCategories.contains(category);

              return GestureDetector(
                onTap: () {
                  final categoriesNotifier = ref.read(
                    selectedCategoriesProvider.notifier,
                  );

                  final secondCategoriesNotifier = ref.read(
                    selectedSecondCategoriesProvider.notifier,
                  );

                  final updatedCategories = [...selectedCategories];
                  final updatedSecondCategories = [...selectedSecondCategories];

                  if (!isSelected) {
                    updatedCategories.add(category);
                    secondCategoriesMap.when(
                      data: (data) {
                        final secondCats = data[category] ?? [];
                        for (final secCat in secondCats) {
                          if (!updatedSecondCategories.contains(secCat)) {
                            updatedSecondCategories.add(secCat);
                          }
                        }
                      },
                      error: (_, __) {},
                      loading: () {},
                    );
                  } else {
                    updatedCategories.remove(category);
                    secondCategoriesMap.when(
                      data: (data) {
                        final secondCats = data[category] ?? [];
                        for (final secCat in secondCats) {
                          updatedSecondCategories.remove(secCat);
                        }
                      },
                      error: (_, __) {},
                      loading: () {},
                    );
                  }

                  categoriesNotifier.state = updatedCategories;
                  secondCategoriesNotifier.state = updatedSecondCategories;

                  print(updatedCategories);
                  print(updatedSecondCategories);
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
                  child: Text(
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
                ),
              );
            },
          ),
        );
      },
      loading:
          () => Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: kPrimaryRed,
                strokeWidth: 2.5, // facultatif, pour un cercle plus fin
              ),
            ),
          ),
      error: (err, stack) => Center(child: Text('Erreur: $err')),
    );
  }
}
