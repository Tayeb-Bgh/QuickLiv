import 'package:auto_size_text/auto_size_text.dart';
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
    final Color textColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    final radius = MediaQuery.of(context).size.height * 0.04;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StoryPage(restaurant: restaurant),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: width * 0.18,
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
          SizedBox(height: height * 0.001), // Space between image and text
          SizedBox(
            width:
                width *
                0.175, /////////////////// PEUT ETRE ICI AUSSIIIIIIIIIIIIIIIII
            child: AutoSizeText(
              restaurant.name,
              style: TextStyle(color: textColor, fontSize: width * 0.025),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
