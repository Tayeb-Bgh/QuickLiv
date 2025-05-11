import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart'; /* 
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart'; */
import 'package:mobileapp/features/customer/favourites/business/entities/business_entity.dart';
import 'package:mobileapp/features/customer/favourites/presentation/widgets/business_card.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/groceries/presentation/providers/groceries_provider.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/pages/grocery_opened_page.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/providers/grocery_opened_provider.dart';
import 'package:mobileapp/features/customer/restaurant_opened/presentation/pages/restaurant_opened_page.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';

class VerticalMarketList extends ConsumerWidget {
  final AsyncValue<List<Business>> businesses;
  final Function onRefresh;
  final bool isFull = true;

  const VerticalMarketList({
    super.key,
    required this.businesses,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /* final isDarkMode = ref.watch(darkModeProvider); */

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: businesses.when(
        data:
            (bsnss) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.74,
                  child: ListView.builder(
                    itemCount: bsnss.length,
                    itemBuilder: (context, index) {
                      final grocer = bsnss[index];
                      return GestureDetector(
                        onTap: () {
                          if (grocer.type == 'grocery') {
                            ref.read(searchTextProvider.notifier).state = "";
                            ref
                                .watch(selectedCategoriesProvider.notifier)
                                .state = [];
                            ref
                                .watch(
                                  selectedSecondCategoriesProvider.notifier,
                                )
                                .state = [];
                            ref.watch(selectedCategoryProvider.notifier).state =
                                null;
                            ref
                                .watch(selectedSecondCategoryProvider.notifier)
                                .state = null;

                            ref
                                .read(selectedGroceryProvider.notifier)
                                .state = Grocery(
                              id: grocer.id,
                              name: grocer.name,
                              category: "",
                              description: grocer.desc,
                              imgUrl: grocer.imgUrlBusns ?? "",
                              vidUrl: "",
                              delivPrice: grocer.deliveryPrice,
                              delivTime: grocer.deliveryTime,
                              rating: grocer.rating,
                              liked: true,
                              distance: 1231312,
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GroceryOpenedPage(),
                              ),
                            );
                          } else {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              isScrollControlled: true,
                              builder:
                                  (_) => RestaurantBottomSheet(
                                    restaurant: Restaurant(
                                      id: grocer.id,
                                      name: grocer.name,
                                      category: "",
                                      description: grocer.desc,
                                      imgUrl: grocer.imgUrlBusns ?? "",
                                      vidUrl: "",
                                      delivPrice: grocer.deliveryPrice,
                                      delivTime: grocer.deliveryTime,
                                      rating: grocer.rating,
                                      liked: true,
                                      distance: 5,
                                    ),
                                  ),
                            );
                          }
                        },
                        child: BusinessCard(
                          grocery: grocer,
                          onRemove: () async {
                            await onRefresh();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
        error: (err, _) => const Text('Une erreur est survenue'),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
