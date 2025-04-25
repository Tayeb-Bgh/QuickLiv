import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';

class RestaurantCard extends ConsumerWidget {
  final bool isFull;
  final Restaurant restaurant;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.isFull,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final coverHeight = isFull ? height * 0.216 : height * 0.131;
    final bool isDarkMode = ref.watch(darkModeProvider);

    final Color likeBtnColor = isDarkMode ? kSecondaryDark : kSecondaryWhite;
    final Color footerBgColor = isDarkMode ? kSecondaryDark : kPrimaryWhite;
    final Color footerTitleColor = isDarkMode ? kSecondaryWhite : kPrimaryBlack;
    final Color footerTextColor = isDarkMode ? kLightGray : kMediumGray;
    final Color iconColor = kPrimaryRed;

    return SizedBox(
      height: isFull ? height * 0.33 : height * 0.31,
      width: isFull ? width * 0.9 : width * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Stack(
              children: [
                Image.network(
                  restaurant.imgUrl,
                  width: double.infinity,
                  height: coverHeight,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap:
                        () => {print("${restaurant.name} ajouté à favoris !")},
                    child: Container(
                      height: isFull ? 43 : 36,
                      width: isFull ? 43 : 36,
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        color: likeBtnColor,
                      ),
                      child: Icon(
                        restaurant.liked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: restaurant.liked ? kPrimaryRed : kMediumGray,
                        size: isFull ? 33 : 28,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: isFull ? height * 0.11 : height * 0.099,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: footerBgColor,
              boxShadow: [
                BoxShadow(
                  color: kPrimaryBlur,
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 10, right: 10, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AutoSizeText(
                    restaurant.name,
                    style: TextStyle(
                      color: footerTitleColor,
                      fontSize: isFull ? width * 0.049 : width * 0.036,
                      fontWeight: FontWeight.w900,
                    ),
                    maxLines: 1,
                    minFontSize: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: AutoSizeText(
                      restaurant.description,
                      style: TextStyle(
                        fontSize: isFull ? width * 0.033 : width * 0.026,
                        color: footerTextColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: height * 0.0039),
                  Row(
                    spacing: isFull ? width * 0.028 : width * 0.019,
                    children: [
                      Row(
                        spacing: width * 0.01,
                        children: [
                          Icon(
                            Icons.delivery_dining,
                            size: isFull ? width * 0.06 : width * 0.038,
                            color: iconColor,
                          ),
                          Text(
                            "${restaurant.delivPrice}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: isFull ? width * 0.04 : width * 0.031,
                              color: footerTextColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 2),

                      Row(
                        spacing: width * 0.01,
                        children: [
                          Icon(
                            Icons.timer,
                            size: isFull ? width * 0.055 : width * 0.035,
                            color: iconColor,
                          ),

                          Text(
                            parseTime(restaurant.delivTime),
                            style: TextStyle(
                              fontSize: isFull ? width * 0.04 : width * 0.031,
                              fontWeight: FontWeight.bold,
                              color: footerTextColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 2),

                      Row(
                        spacing: width * 0.01,
                        children: [
                          Icon(
                            Icons.star,
                            size: isFull ? width * 0.06 : width * 0.038,
                            color: iconColor,
                          ),

                          Text(
                            restaurant.rating.toString(),
                            style: TextStyle(
                              fontSize: isFull ? width * 0.04 : width * 0.031,
                              fontWeight: FontWeight.bold,
                              color: footerTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
