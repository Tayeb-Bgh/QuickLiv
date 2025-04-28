import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/story/presentation/pages/story_page.dart';

class RestaurantStoryBtn extends ConsumerWidget {
  final Restaurant restaurant;

  const RestaurantStoryBtn({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    final radius = MediaQuery.of(context).size.height * 0.04;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => StoryPage(
               restaurant: restaurant,
                ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: width * 0.21,
            padding: const EdgeInsets.all(3), // Red stroke thickness
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: kPrimaryRed, // Outer red ring
            ),
            child: Container(
              padding: const EdgeInsets.all(
                3,
              ), // GAP between red ring and image
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDarkMode ? kPrimaryDark : kSecondaryWhite,
              ),
              child: CircleAvatar(
                radius: radius,
                backgroundImage: NetworkImage(restaurant.imgUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
