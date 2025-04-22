import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/groceries/presentation/widgets/grocery_card.dart';

class GroceriesListView extends ConsumerWidget {
  
  final AsyncValue<List<Grocery>> groceries;
  final String title = "Notre sélection du jour";
  final Function onRefresh;
  final isFull = false;
  const GroceriesListView({
    super.key,
    required this.groceries,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    final height = MediaQuery.of(context).size.height ;
    final width = MediaQuery.of(context).size.width;

    final Color titleColor = isDarkMode ? kSecondaryWhite : kPrimaryRed;

    return ColoredBox(
      color: isDarkMode ? kPrimaryDark : kSecondaryWhite,
      child: Container(
        padding: EdgeInsets.only(left: 15),
        margin: EdgeInsets.only(bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              
              style: TextStyle(
                color: titleColor,
                fontWeight: FontWeight.bold,
                fontSize: width * 0.060,
              ),
            ),
            SizedBox(height: 6),
            groceries.when(
              data:
                  (groceries) => RefreshIndicator(
                    onRefresh: () => onRefresh(),
                    child: SizedBox(
                      height: height * 0.243,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: groceries.length,
                        itemBuilder: (context, index) {
                          final grocer = groceries[index];
                          return Container(
                            margin: EdgeInsets.only(right: 10),
                            child: GroceryCard(grocery: grocer, isFull: isFull),
                          );
                        },
                      ),
                    ),
                  ),
              error: (err, _) => Text('errooor'),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
