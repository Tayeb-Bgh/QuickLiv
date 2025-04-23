import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/restaurants/presentation/widgets/restaurant_card.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';

class RestaurantsListView extends ConsumerWidget {
  final AsyncValue<List<Restaurant>> restaurants;
  final String title = "Notre sélection du jour";
  final Function onRefresh;
  final isFull = false;
  const RestaurantsListView({
    super.key,
    required this.restaurants,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final Color titleColor = isDarkMode ? kSecondaryWhite : kPrimaryRed;

    return ColoredBox(
      color: isDarkMode ? kPrimaryDark : kSecondaryWhite,
      child: Container(
        padding: EdgeInsets.only(left: width * kDefaultPadding),
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
            restaurants.when(
              data:
                  (restaurants) => RefreshIndicator(
                    onRefresh: () => onRefresh(),
                    child: SizedBox(
                      height: height * 0.243,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: restaurants.length,
                        itemBuilder: (context, index) {
                          final restau = restaurants[index];
                          return Container(
                            margin: EdgeInsets.only(right: 10),
                            child: RestaurantCard(
                              restaurant: restau,
                              isFull: isFull,
                            ),
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
