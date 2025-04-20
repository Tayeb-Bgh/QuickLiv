import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/product_with_reduc_entity.dart';
import 'package:mobileapp/features/customer/groceries/presentation/widgets/product_reduc_card.dart';

class ReductionsListView extends ConsumerWidget {
  final AsyncValue<List<ProductWithReduc>> reductions;
  final String title = "Nos meilleures réductions";
  final Color titleColor = kPrimaryRed;
  final Function onRefresh;
  final isFull = false;
  const ReductionsListView({
    super.key,
    required this.reductions,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height * 0.27;

    return ColoredBox(
      color: kPrimaryDark,
      child: Container(
        padding: EdgeInsets.only(left: 15),
        margin: EdgeInsets.only(bottom: 10),
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
                fontSize: 24,
              ),
            ),
            reductions.when(
              data:
                  (reductions) => RefreshIndicator(
                    onRefresh: () => onRefresh(),
                    child: SizedBox(
                      height: height,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: reductions.length,
                        itemBuilder: (context, index) {
                          final reduction = reductions[index];
                          return Container(
                            margin: EdgeInsets.only(right: 10),
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
