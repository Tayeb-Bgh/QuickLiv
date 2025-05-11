import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/restaurant_opened/presentation/pages/restaurant_opened_page.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';
import 'package:story_view/story_view.dart';

class StoryPage extends StatelessWidget {
  final StoryController controller = StoryController();
  final Restaurant? restaurant;
  final Grocery? grocery;
  StoryPage({super.key, this.restaurant, this.grocery});
  @override
  Widget build(BuildContext context) {
    List<StoryItem> storyItems = [
      StoryItem.pageVideo(
        restaurant == null
            ? (grocery?.vidUrl ?? '')
            : (restaurant?.vidUrl ?? ''),
        controller: controller,
        imageFit: BoxFit.cover,
      ),
    ];

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: StoryView(
              storyItems: storyItems,
              controller: controller,
              inline: false,
              repeat: true,
              indicatorForegroundColor: kPrimaryWhite,
              onComplete: () {},
              onVerticalSwipeComplete: (direction) {
                if (direction == Direction.down) {
                  Navigator.pop(context);
                }
              },
            ),
          ),

          Positioned(
            top: height * 0.0605,
            left: width * 0.05,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    restaurant == null
                        ? (grocery?.imgUrl ?? '')
                        : (restaurant?.imgUrl ?? ''),
                  ),
                ),
                SizedBox(width: width * 0.02),
                Text(
                  restaurant == null
                      ? (grocery?.name ?? 'dgdgcudghcuidjcg')
                      : (restaurant?.name ?? 'cujhdcjhcd'),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: height * 0.03,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryRed,
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.1, // Adjusted for better button size
                    vertical: 15, // Slightly increased vertical padding
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      15,
                    ), // Round corners more
                  ),
                  minimumSize: Size(width * 0.6, height * 0.05),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  if (restaurant != null) {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      isScrollControlled: true,
                      builder:
                          (_) => RestaurantBottomSheet(restaurant: restaurant!),
                    );
                  } else if (grocery != null) {}
                },
                child: Text(
                  "Decouvrir le Menu",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ), // Adjusted text size
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
