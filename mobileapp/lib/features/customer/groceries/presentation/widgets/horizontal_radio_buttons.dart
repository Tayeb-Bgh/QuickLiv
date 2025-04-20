import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/groceries/presentation/providers/groceries_provider.dart';

class HorizontalRadioButtons extends ConsumerWidget {
  const HorizontalRadioButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedCategoryProvider);
    final categories = [
      {'label': 'Superétte', 'icon': Icons.store},
      {'label': "Supermarché", 'icon': Icons.store},
      {'label': 'Boucherie', 'icon': Icons.set_meal},
      {'label': "Fruits & Légumes", 'icon': Icons.local_grocery_store},
      {'label': "Boulangerie", 'icon': Icons.breakfast_dining},
      {'label': "Poissonnerie", 'icon': Icons.set_meal},
      {'label': "Fromagerie", 'icon': Icons.lunch_dining},
      {'label': "Épices", 'icon': Icons.eco},
    ];

    return SizedBox(
      height: 40,
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
              final selected = isSelected ? null : category['label'] as String;
              ref.read(selectedCategoryProvider.notifier).state = selected;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? kPrimaryRed : Colors.transparent,
                border: Border.all(color: kPrimaryRed, width: 2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(
                    category['icon'] as IconData,
                    color: isSelected ? Colors.white : kPrimaryRed,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    category['label'] as String,
                    style: TextStyle(
                      color: isSelected ? Colors.white : kPrimaryRed,
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
