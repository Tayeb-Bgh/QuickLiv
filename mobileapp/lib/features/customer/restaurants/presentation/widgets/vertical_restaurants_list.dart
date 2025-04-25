import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/restaurant_opened/presentation/pages/restaurant_opened_page.dart';
import 'package:mobileapp/features/customer/restaurants/presentation/providers/restaurants_provider.dart';
import 'package:mobileapp/features/customer/restaurants/presentation/widgets/restaurant_card.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';

class VerticalRestaurantsListView extends ConsumerWidget {
  final AsyncValue<List<Restaurant>> restaurants;
  final Function onRefresh;
  final isFull = true;

  const VerticalRestaurantsListView({
    super.key,
    required this.restaurants,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    final titleColor = isDarkMode ? kSecondaryWhite : kPrimaryRed;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: restaurants.when(
        data:
            (restaurants) => Column(
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
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    final restau = restaurants[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            isScrollControlled: true,
                            builder:
                                (_) =>
                                    RestaurantBottomSheet(restaurant: restau),
                          );
                        },
                        child: RestaurantCard(
                          restaurant: restau,
                          isFull: isFull,
                        ),
                      ),
                    );
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
