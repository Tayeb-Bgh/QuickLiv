import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/restaurant_opened/presentation/pages/restaurant_opened_page.dart';
import 'package:mobileapp/features/customer/restaurants/presentation/widgets/restaurant_card.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';

class RestaurantsListView extends ConsumerStatefulWidget {
  final AsyncValue<List<Restaurant>> restaurants;
  final String title;
  final Function onRefresh;
  final isFull = false;
  const RestaurantsListView({
    super.key,
    required this.restaurants,
    required this.onRefresh,
    this.title = "Notre sélection du jour",
  });

  @override
  ConsumerState<RestaurantsListView> createState() =>
      _RestaurantsListViewState();
}

class _RestaurantsListViewState extends ConsumerState<RestaurantsListView> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToNextItem() {
    if (_scrollController.hasClients) {
      
      final cardWidth = MediaQuery.of(context).size.width * 0.6;

      
      final nextPosition =
          _scrollController.offset + cardWidth + 10; 
      _scrollController.animateTo(
        nextPosition,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(darkModeProvider);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final Color titleColor = isDarkMode ? kSecondaryWhite : kPrimaryRed;
    final Color btnBgColor = isDarkMode ? kSecondaryWhite : kPrimaryRed;
    final Color btnIconColor = isDarkMode ? kPrimaryBlack : kPrimaryWhite;

    return ColoredBox(
      color: isDarkMode ? kPrimaryDark : kSecondaryWhite,
      child: Container(
        padding: EdgeInsets.only(left: width * kDefaultPadding),
        margin: EdgeInsets.only(bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Nos meilleurs restaurants",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: titleColor,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.060,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: _scrollToNextItem,
                  icon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: btnBgColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: btnIconColor,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            widget.restaurants.when(
              data:
                  (restaurants) => RefreshIndicator(
                    onRefresh: () => widget.onRefresh(),
                    child: SizedBox(
                      height: height * 0.243,
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: restaurants.length,
                        itemBuilder: (context, index) {
                          final restau = restaurants[index];
                          return Container(
                            margin: EdgeInsets.only(right: 10),
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
                                      (_) => RestaurantBottomSheet(
                                        restaurant: restau,
                                      ),
                                );
                              },
                              child: RestaurantCard(
                                restaurant: restau,
                                isFull: widget.isFull,
                              ),
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
