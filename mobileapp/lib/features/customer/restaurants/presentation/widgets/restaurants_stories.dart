import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';
import 'package:mobileapp/features/customer/restaurants/presentation/widgets/restaurant_story_btn.dart';

class RestaurantsStoriesList extends ConsumerWidget {
  final AsyncValue<List<Restaurant>> restaurants;
  final Function onRefresh;
  const RestaurantsStoriesList({
    super.key,
    required this.restaurants,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isDarkMode = ref.watch(darkModeProvider);
    return ColoredBox(
      color: isDarkMode ? kPrimaryDark : kSecondaryWhite,
      child: Container(
        margin: EdgeInsets.only(top: height * 0.01),
        padding: EdgeInsets.only(left: width * kDefaultPadding),
        child: restaurants.when(
          data:
              (restaurants) => RefreshIndicator(
                onRefresh: () => onRefresh(),
                child: SizedBox(
                  height:
                      height *
                      0.123, //////////////////////////////////ICIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII STORYYYYYYYYYYYYY OVERFLOOOOOOOOOOOOOOW
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: restaurants.length,
    
                    itemBuilder: (context, index) {
                      final restau = restaurants[index];
    
                      return Padding(
                        padding: EdgeInsets.only(
                          right: width * 0.025,
                        ), // Réduit l'écart ici
                        child: RestaurantStoryBtn(restaurant: restau),
                      );
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
