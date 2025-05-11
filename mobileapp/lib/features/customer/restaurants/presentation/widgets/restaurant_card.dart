import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';
import 'package:mobileapp/features/customer/favourites/presentation/providers/favourites_provider.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';

class RestaurantCard extends ConsumerWidget {
  final bool isFull;
  final Restaurant restaurant;
  final VoidCallback? onRemove;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.isFull,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);

    final Color likeBtnColor = isDarkMode ? kSecondaryDark : kSecondaryWhite;
    final Color footerBgColor = isDarkMode ? kSecondaryDark : kPrimaryWhite;
    final Color footerTitleColor = isDarkMode ? kSecondaryWhite : kPrimaryBlack;
    final Color footerTextColor = isDarkMode ? kLightGray : kMediumGray;
    final Color iconColor = kPrimaryRed;

    final favIds = ref.watch(favouriteProvider);

    ref.listen(userFavouritesProvider, (previous, next) {
      final ids = next.asData?.value;
      if (ids != null) {
        final currentFavs = ref.read(favouriteProvider);
        ref.read(favouriteProvider.notifier).state = {
          ...currentFavs,
          ...ids.toSet(),
        };
      }
    });

    final isLiked = favIds.contains(restaurant.id);

    return SizedBox(
      height: isFull ? 260 : 240,
      width: isFull ? 360 : 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Stack(
              children: [
                Image.network(
                  restaurant.imgUrl,
                  width: double.infinity,
                  height: isFull ? 160 : 100,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    height: isFull ? 43 : 36,
                    width: isFull ? 43 : 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: likeBtnColor,
                    ),
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? kPrimaryRed : kMediumGray,
                          size: 22,
                        ),
                        onPressed: () {
                          if (isLiked) {
                            ref
                                .read(favouriteProvider.notifier)
                                .removeFavourite(restaurant.id);
                            if (onRemove != null) onRemove!();
                          } else {
                            ref
                                .read(favouriteProvider.notifier)
                                .addFavourite(restaurant.id);
                          }
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: isFull ? 85 : 75,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: footerBgColor,
              boxShadow: const [
                BoxShadow(
                  color: kPrimaryBlur,
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AutoSizeText(
                    restaurant.name,
                    style: TextStyle(
                      color: footerTitleColor,
                      fontSize: isFull ? 18 : 14,
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
                        fontSize: isFull ? 12 : 10,
                        color: footerTextColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.delivery_dining,
                            size: isFull ? 22 : 16,
                            color: iconColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${restaurant.delivPrice.toStringAsFixed(2)} DZD",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: isFull ? 14 : 12,
                              color: footerTextColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            size: isFull ? 20 : 15,
                            color: iconColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            parseTime(restaurant.delivTime),
                            style: TextStyle(
                              fontSize: isFull ? 14 : 12,
                              fontWeight: FontWeight.bold,
                              color: footerTextColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: isFull ? 22 : 16,
                            color: iconColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            restaurant.rating.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: isFull ? 14 : 12,
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
