import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';
import 'package:mobileapp/features/customer/favourites/presentation/providers/favourites_provider.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/groceries/presentation/providers/groceries_provider.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/pages/grocery_opened_page.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/providers/grocery_opened_provider.dart';

class GroceryCard extends ConsumerWidget {
  final bool isFull;
  final Grocery grocery;
  final VoidCallback? onRemove;

  const GroceryCard({
    super.key,
    required this.grocery,
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

    final isLiked = favIds.contains(grocery.id);

    return GestureDetector(
      onTap: () {
        ref.read(searchTextProvider.notifier).state = "";
        ref.watch(selectedCategoriesProvider.notifier).state = [];
        ref.watch(selectedSecondCategoriesProvider.notifier).state = [];
        ref.watch(selectedCategoryProvider.notifier).state = null;
        ref.watch(selectedSecondCategoryProvider.notifier).state = null;
        ref.read(selectedGroceryProvider.notifier).state = grocery;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GroceryOpenedPage()),
        );
      },
      child: SizedBox(
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
                    grocery.imgUrl,
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
                                  .removeFavourite(grocery.id);
                              if (onRemove != null) onRemove!();
                            } else {
                              ref
                                  .read(favouriteProvider.notifier)
                                  .addFavourite(grocery.id);
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
                      grocery.name,
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
                        grocery.description,
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
                              "${grocery.delivPrice.toStringAsFixed(2)} DZD",
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
                              parseTime(grocery.delivTime),
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
                              grocery.rating.toStringAsFixed(1),
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
      ),
    );
  }
}
