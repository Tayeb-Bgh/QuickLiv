import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:story_view/story_view.dart';

class StoryPage extends StatelessWidget {
  final StoryController controller = StoryController();
  final String storeName;
  final String storevidUrl;
  final String storeImageUrl;
  StoryPage({
    super.key,
    required this.storeName,
    required this.storevidUrl,
    required this.storeImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    List<StoryItem> storyItems = [
      StoryItem.pageVideo(storevidUrl, controller: controller),
    ];

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          StoryView(
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

          Positioned(
            top: height * 0.05,
            left: width * 0.05,
            child: Row(
              children: [
                CircleAvatar(backgroundImage: NetworkImage(storeImageUrl)),
                SizedBox(width: width * 0.02),
                Text(
                  storeName,
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
                onPressed: () {},
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
