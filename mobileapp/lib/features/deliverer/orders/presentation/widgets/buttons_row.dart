import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/deliverer/orders/presentation/providers/orders_providers.dart';

class HorizontalRadioButtons extends ConsumerWidget {
  const HorizontalRadioButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = [
      {'label': 'En attente'},
      {'label': "En cours"},
    ];
    final selectedIndex = ref.watch(selectedCategoryIndexProvider);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _createButton(
          width,
          height,
          categories[0]['label']!,
          true,
          selectedIndex,
          ref,
        ),
        _createButton(
          width,
          height,
          categories[1]['label']!,
          false,
          selectedIndex,
          ref,
        ),
      ],
    );
  }

  Widget _createButton(
    double width,
    double height,
    String label,
    bool value,
    bool selectedIndex,
    WidgetRef ref,
  ) {
    bool isSelected = value == selectedIndex;
    return GestureDetector(
      onTap: () {
        ref.read(selectedCategoryIndexProvider.notifier).state = value;
      },
      child: AnimatedContainer(
        height: height * 0.045,
        width: width * 0.4,
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.transparent,
          border: Border.all(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
