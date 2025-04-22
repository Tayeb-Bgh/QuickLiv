import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/product_with_reduc_entity.dart';
import 'package:mobileapp/features/customer/groceries/presentation/widgets/product_reduc_card.dart';

class ReductionsListView extends ConsumerWidget {
  final AsyncValue<List<ProductWithReduc>> reductions;
  final String title = "Nos réductions du jour";
  
  final Function onRefresh;
  final isFull = false;
  const ReductionsListView({
    super.key,
    required this.reductions,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height ;
    final width = MediaQuery.of(context).size.width;

    final isDarkMode = ref.watch(darkModeProvider);

    final Color titleColor = isDarkMode ? kSecondaryWhite : kPrimaryRed;

    return ColoredBox(
      color: isDarkMode ? kPrimaryDark : kSecondaryWhite,
      child: Container(
        padding: EdgeInsets.only(left: 15,bottom: 10),
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
            reductions.when(
              data:
                  (reductions) => RefreshIndicator(
                    onRefresh: () => onRefresh(),
                    child: SizedBox(
                      height: height * 0.203,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: reductions.length,
                        itemBuilder: (context, index) {
                          final reduction = reductions[index];
                          return Container(
                            margin: EdgeInsets.only(right: 10 ,bottom: 8),
                            child: ProductReducCard(product: reduction),
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
