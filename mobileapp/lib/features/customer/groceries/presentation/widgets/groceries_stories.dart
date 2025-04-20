import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/groceries/presentation/widgets/business_story_btn.dart';

class GroceriesStoriesList extends ConsumerWidget {
  final AsyncValue<List<Grocery>> groceries;
  final Function onRefresh;
  const GroceriesStoriesList({
    super.key,
    required this.groceries,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height * 0.15;

    return ColoredBox(
      color: kPrimaryDark,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(left: 5, right: 5),
        child: groceries.when(
          data:
              (groceries) => RefreshIndicator(
                onRefresh: () => onRefresh(),
                child: SizedBox(
                  height: height,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: groceries.length,
                    itemBuilder: (context, index) {
                      final grocer = groceries[index];
                      return BusinessStoryBtn(grocery: grocer);
                    },
                  ),
                ),
              ),
          error: (err, _) => Text('errooor'),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
