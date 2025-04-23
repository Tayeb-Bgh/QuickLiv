import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/groceries/presentation/providers/groceries_provider.dart';
import 'package:mobileapp/features/customer/groceries/presentation/widgets/grocery_card.dart';

class VerticalMarketList extends ConsumerWidget {
  final AsyncValue<List<Grocery>> groceries;
  final Function onRefresh;
  final isFull = true;

  const VerticalMarketList({
    super.key,
    required this.groceries,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    final titleColor = isDarkMode ? kSecondaryWhite : kPrimaryRed;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: groceries.when(
        data: (groceries) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ref.watch(selectedCategoryProvider) != null
                  ? "Nos ${ref.watch(selectedCategoryProvider)}s"
                  : "Nos Magasins",
              style: TextStyle(
                color: titleColor,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            // Liste non scrollable, intégrée dans scroll global
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: groceries.length,
              itemBuilder: (context, index) {
                final grocer = groceries[index];
                return Container(
                  margin: EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: GroceryCard(grocery: grocer, isFull: isFull));
              },
            ),
          ],
        ),
        error: (err, _) => const Text('Une erreur est survenue'),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
