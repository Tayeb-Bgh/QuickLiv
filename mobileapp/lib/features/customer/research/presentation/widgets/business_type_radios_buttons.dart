import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/research/presentation/providers/research_provider.dart';

class BusinessTypeRadiosButtons extends ConsumerWidget {
  final double parentHeight;
  BusinessTypeRadiosButtons({super.key, required this.parentHeight});
  final categories = ["Courses", "Restaurants"];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isDarkMode = ref.watch(darkModeProvider);

    final selected = ref.watch(selectedTypeProvider);
    return Container(
      color: isDarkMode ? kPrimaryDark : kSecondaryWhite,
      width: width,
      height: parentHeight * 0.5,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(categories.length, (index) {
              final category = categories[index];
              final isSelected = selected == category;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: GestureDetector(
                  onTap: () {
                    final selected = isSelected ? null : category;
                    ref.read(selectedTypeProvider.notifier).state = selected;
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 9,
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
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
