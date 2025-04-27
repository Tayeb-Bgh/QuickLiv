import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/restaurants/presentation/widgets/restaurants_list_view.dart';
import 'package:mobileapp/features/customer/restaurants/presentation/widgets/restaurants_stories.dart';
import 'package:mobileapp/features/customer/restaurants/presentation/widgets/horizontal_radio_buttons.dart';
import 'package:mobileapp/features/customer/restaurants/presentation/widgets/best_products_list_view.dart';
import 'package:mobileapp/features/customer/restaurants/presentation/widgets/vertical_restaurants_list.dart';
import '../providers/restaurants_provider.dart';

class RestaurantsPageTest extends ConsumerStatefulWidget {
  const RestaurantsPageTest({super.key});

  @override
  ConsumerState<RestaurantsPageTest> createState() =>
      _RestaurantsPageTestState();
}

class _RestaurantsPageTestState extends ConsumerState<RestaurantsPageTest> {
  Future<void> _refresh() async {
    return await ref.refresh(restaurantsListProvider);
  }

  Future<void> _refreshRestaurantsByCategoy() async {
    ref.invalidate(restaurantsByCategoryListProvider);
  }

  @override
  Widget build(BuildContext context) {
    final asyncRestaurantsList = ref.watch(restaurantsListProvider);
    final asyncRestaurantsByCategoryList = ref.watch(
      restaurantsByCategoryListProvider,
    );
    final asynBestProductsList = ref.watch(bestProductsListProvider);

    final isDarkMode = ref.watch(darkModeProvider);
    final bgColor = isDarkMode ? kPrimaryDark : kSecondaryWhite;

    final height = MediaQuery.of(context).size.height;

    return ColoredBox(
      color: bgColor,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: RestaurantsStoriesList(
              restaurants: asyncRestaurantsList,
              onRefresh: _refresh,
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: height * 0)),

          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyRadioButtonsDelegate(
              isDarkMode: isDarkMode,
              height: height,
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: height * 0)),

          SliverToBoxAdapter(
            child: BestProductsListView(
              bestProducts: asynBestProductsList,
              onRefresh: _refresh,
            ),
          ),
          SliverToBoxAdapter(
            child: RestaurantsListView(
              restaurants: asyncRestaurantsList,
              onRefresh: _refresh,
            ),
          ),
          SliverToBoxAdapter(
            child: VerticalRestaurantsListView(
              restaurants: asyncRestaurantsByCategoryList,
              onRefresh: _refreshRestaurantsByCategoy,
            ),
          ),
        ],
      ),
    );
  }
}

class _StickyRadioButtonsDelegate extends SliverPersistentHeaderDelegate {
  final bool isDarkMode;
  final double height;
  _StickyRadioButtonsDelegate({required this.isDarkMode, required this.height});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: isDarkMode ? kPrimaryDark : kSecondaryWhite,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.015),
        child: HorizontalRadioButtons(),
      ),
    );
  }

  @override
  double get maxExtent => height * 0.0675;

  @override
  double get minExtent => height * 0.0675;

  @override
  bool shouldRebuild(_StickyRadioButtonsDelegate oldDelegate) => true;
}
