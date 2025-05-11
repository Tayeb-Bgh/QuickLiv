import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/groceries/presentation/providers/groceries_provider.dart';
import 'package:mobileapp/features/customer/home/presentation/providers/home_provider.dart';
import 'package:mobileapp/features/customer/home/presentation/widgets/advertisement_card.dart';
import 'package:mobileapp/features/customer/home/presentation/widgets/delivery_state_widget.dart';
import 'package:mobileapp/features/customer/home/presentation/widgets/location.dart';
import 'package:mobileapp/features/customer/groceries/presentation/widgets/groceries_list_view.dart';
import 'package:mobileapp/features/customer/restaurants/presentation/providers/restaurants_provider.dart';
import 'package:mobileapp/features/customer/restaurants/presentation/widgets/restaurants_list_view.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);
    final Color dotColor = isDarkMode ? kSecondaryWhite : kPrimaryRed;
    final Color bgColor = isDarkMode ? kPrimaryDark : kSecondaryWhite;

    final asyncGroceriesList = ref.watch(groceriesListProvider);
    final asyncRestaurantsList = ref.watch(restaurantsListProvider);
    final asyncReductionsList = ref.watch(bestReductionsListProvider);

    final width = MediaQuery.of(context).size.width;

    return Container(
      height: MediaQuery.of(context).size.height,
      color: bgColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: kDefaultPadding * width),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 250, child: Location()),
                  DeliveryStateWidget(state: true),
                ],
              ),
            ),
            SizedBox(
              height: 230, // ou ce que tu veux
              child: asyncReductionsList.when(
                data: (reductionsList) {
                  return Swiper(
                    itemCount: reductionsList.length,
                    itemBuilder: (context, index) {
                      final productReduc = reductionsList[index];

                      return AdvertisementCard(product: productReduc);
                    },
                    indicatorLayout: PageIndicatorLayout.COLOR,
                    autoplay: true,
                    pagination: SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                        color: kLightGray,
                        activeColor: dotColor,
                        size: 8.0,
                        activeSize: 10.0,
                      ),
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Erreur : $error')),
              ),
            ),
            RestaurantsListView(
              title: "Nos restaurants",
              restaurants: asyncRestaurantsList,
              onRefresh: () {},
            ),
            GroceriesListView(
              title: "Nos magasins",
              groceries: asyncGroceriesList,
              onRefresh: () {},
            ),
          ],
        ),
      ),
    );
  }
}
