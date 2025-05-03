import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/deliverer/history/presentation/providers/deliverer_history_provider.dart';

class HorizontalRadioButtons extends ConsumerWidget {
  const HorizontalRadioButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedFilterProvider);
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

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
              final selected = isSelected ? null : category['label'] as String;
              ref.read(selectedFilterProvider.notifier).state = selected;
              print("[DEBUUUUUUUUG] $selected");
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
