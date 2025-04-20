import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/groceries/presentation/providers/groceries_provider.dart';
import 'package:mobileapp/features/customer/groceries/presentation/widgets/grocery_card.dart';
import 'package:mobileapp/features/customer/groceries/presentation/widgets/horizontal_radio_buttons.dart';

class VerticalMarketList extends ConsumerWidget {
  final AsyncValue<List<Grocery>> groceries;
  final Function onRefresh;
  final isFull = true;
  final titleColor = kPrimaryRed;

  const VerticalMarketList({
    super.key,
    required this.groceries,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const HorizontalRadioButtons filters = HorizontalRadioButtons();
    final height = MediaQuery.of(context).size.height * 0.83;
    return Container(
      height: height,
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ref.watch(selectedCategoryProvider) != null
                ? "Nos ${ref.watch(selectedCategoryProvider)}s"
                : "Nos Magasins",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: titleColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          filters,
          SizedBox(height: 10),
          Expanded(
            child: groceries.when(
              data:
                  (groceries) => RefreshIndicator(
                    onRefresh: () => onRefresh(),
                    child: ListView.builder(
                      itemCount: groceries.length,
                      itemBuilder: (context, index) {
                        final grocer = groceries[index];
                        return GroceryCard(grocery: grocer, isFull: isFull);
                      },
                    ),
                  ),
              error: (err, _) => Text('errooor'),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
