import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';

class GroceryCard extends ConsumerWidget {
  final bool isFull;
  final Grocery grocery;

  const GroceryCard({super.key, required this.grocery, required this.isFull});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final coverHeight = isFull ? height * 0.25 : height * 0.15;
    final bool isDarkMode = ref.watch(darkModeProvider);

    final Color likeBtnColor = isDarkMode ? kSecondaryDark : kRegularGray;
    final Color footerBgColor = isDarkMode ? kSecondaryDark : kRegularGray;
    final Color footerTitleColor = isDarkMode ? kSecondaryWhite : kPrimaryBlack;
    final Color footerTextColor = isDarkMode ? kLightGray : kMediumGray;
    final Color iconColor = kPrimaryRed;

    return Container(
      child: Container(
        height: isFull ? height * 0.35 : height * 0.3,
        width: isFull ? width * 0.9 : width * 0.7,
        margin: EdgeInsets.only(bottom: 10),
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
                    grocery.imgUrl,
                    width: double.infinity,
                    height: coverHeight,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap:
                          () => {print("${grocery.name} ajouté à favoris !")},
                      child: Container(
                        height: 30,
                        width: 30,
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          color: likeBtnColor,
                        ),
                        child: Icon(
                          grocery.liked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: grocery.liked ? kPrimaryRed : kMediumGray,
                          size: 21,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: footerBgColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AutoSizeText(
                      grocery.name,
                      style: TextStyle(
                        color: footerTitleColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                      maxLines: 2,
                      minFontSize: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: AutoSizeText(
                        grocery.description,
                        style: TextStyle(fontSize: 10, color: footerTextColor),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    Row(
                      spacing: 2,
                      children: [
                        Icon(Icons.delivery_dining, size: 11, color: iconColor),
                        Text(
                          "${grocery.delivPrice}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: footerTextColor,
                          ),
                        ),
                        const SizedBox(width: 2),

                        Icon(Icons.access_time, size: 11, color: iconColor),

                        Text(
                          parseTime(grocery.delivTime),
                          style: TextStyle(
                            fontSize: 12,
                            color: footerTextColor,
                          ),
                        ),
                        const SizedBox(width: 2),

                        Icon(Icons.star, size: 11, color: iconColor),

                        Text(
                          grocery.rating.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: footerTextColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
