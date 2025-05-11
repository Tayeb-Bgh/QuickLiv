import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/favourites/business/entities/business_entity.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';
import 'package:mobileapp/features/customer/favourites/presentation/providers/favourites_provider.dart';

class BusinessCard extends ConsumerWidget {
  final Business grocery;
  final VoidCallback? onRemove;

  const BusinessCard({super.key, required this.grocery, this.onRemove});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    final isLiked = ref.watch(favouriteProvider).contains(grocery.id);

    final Color likeBtnColor = isDarkMode ? kSecondaryDark : kSecondaryWhite;
    final Color footerBgColor = isDarkMode ? kSecondaryDark : kPrimaryWhite;
    final Color footerTitleColor = isDarkMode ? kSecondaryWhite : kPrimaryBlack;
    final Color footerTextColor = isDarkMode ? kLightGray : kMediumGray;
    final Color iconColor = kPrimaryRed;
    final Color isOpenTxtColor = kPrimaryGreen;
    final Color isOpenBgColor = kPrimaryGreen.withOpacity(0.2);
    final Color isCloseTxtColor = kPrimaryRed;
    final Color isCloseBgColor = kPrimaryRed.withOpacity(0.2);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: 370,
      height: 270,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Stack(
              children: [
                Image.network(
                  grocery.imgUrlBusns!,
                  width: 370,
                  height: 178,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    height: 43,
                    width: 43,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: likeBtnColor,
                    ),
                    child: IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? kPrimaryRed : kMediumGray,
                        size: 26,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: const Text("Confirmer la suppression"),
                                content: const Text(
                                  "Êtes-vous sûr de vouloir supprimer cet élément ?",
                                ),
                                actions: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                    ),
                                    onPressed:
                                        () => Navigator.of(context).pop(),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      if (isLiked) {
                                        ref
                                            .read(favouriteProvider.notifier)
                                            .removeFavourite(grocery.id);
                                      } else {
                                        ref
                                            .read(favouriteProvider.notifier)
                                            .addFavourite(grocery.id);
                                      }
                                      if (onRemove != null && isLiked) {
                                        onRemove!();
                                      }
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 92,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
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
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and open/close
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 200,
                        child: AutoSizeText(
                          grocery.name,
                          style: TextStyle(
                            color: footerTitleColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                          maxLines: 1,
                          minFontSize: 10,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: grocery.open ? isOpenBgColor : isCloseBgColor,
                          border: Border.all(
                            color:
                                grocery.open ? isOpenTxtColor : isCloseTxtColor,
                            width: 1.5,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: AutoSizeText(
                          grocery.open ? "Ouvert" : "Fermé",
                          style: TextStyle(
                            color:
                                grocery.open ? isOpenTxtColor : isCloseTxtColor,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          minFontSize: 10,
                          maxFontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  AutoSizeText(
                    grocery.desc,
                    style: TextStyle(fontSize: 13, color: footerTextColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delivery_dining,
                            size: 22,
                            color: iconColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${grocery.deliveryPrice.toStringAsFixed(2)} DA",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: footerTextColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.timer, size: 19, color: iconColor),
                          const SizedBox(width: 4),
                          Text(
                            parseTime(grocery.deliveryTime),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: footerTextColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          Icon(Icons.star, size: 22, color: iconColor),
                          const SizedBox(width: 4),
                          Text(
                            grocery.rating.toString(),
                            style: TextStyle(
                              fontSize: 16,
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
