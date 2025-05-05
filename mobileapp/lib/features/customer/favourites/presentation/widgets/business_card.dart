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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final coverHeight = height * 0.216;

    final isDarkMode = ref.watch(darkModeProvider);
    final favIdsAsync = ref.watch(userFavouritesProvider);
    final isLiked = favIdsAsync.when(
      data: (ids) => ids.contains(grocery.id),
      loading: () => false,
      error: (_, __) => false,
    );

    final Color likeBtnColor = isDarkMode ? kSecondaryDark : kSecondaryWhite;
    final Color footerBgColor = isDarkMode ? kSecondaryDark : kPrimaryWhite;
    final Color footerTitleColor = isDarkMode ? kSecondaryWhite : kPrimaryBlack;
    final Color footerTextColor = isDarkMode ? kLightGray : kMediumGray;
    final Color iconColor = kPrimaryRed;

    return Container(
      child: Container(
        height: height * 0.33,
        width: width * 0.9,
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
                    grocery.imgUrlBusns!,
                    width: double.infinity,
                    height: coverHeight,
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
                          // Afficher le dialogue de confirmation avant la suppression
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Confirmer la suppression"),
                                content: Text(
                                  "Êtes-vous sûr de vouloir supprimer cet élément ?",
                                ),
                                actions: [
                                  IconButton(
                                    icon: Icon(Icons.cancel, color: Colors.red),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      // Supprimer l'élément si l'utilisateur confirme
                                      if (isLiked) {
                                        ref
                                            .read(favouriteProvider.notifier)
                                            .removeFavourite(grocery.id);
                                      } else {
                                        ref
                                            .read(favouriteProvider.notifier)
                                            .addFavourite(grocery.id);
                                      }

                                      // Si un callback onRemove est passé, on l'appelle
                                      if (onRemove != null && isLiked) {
                                        onRemove!();
                                      }

                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: height * 0.11,
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
                    // Affichage du titre
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(
                          grocery.name,
                          style: TextStyle(
                            color: footerTitleColor,
                            fontSize: width * 0.049,
                            fontWeight: FontWeight.w900,
                          ),
                          maxLines: 2,
                          minFontSize: 10,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 0.7,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  grocery.open
                                      ? Colors.green.shade800
                                      : kPrimaryRed,
                              width: 2,
                            ),
                            color:
                                grocery.open
                                    ? Colors.green.shade200
                                    : Colors.red.shade200,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            grocery.open ? "Ouvert" : "Fermé",
                            style: TextStyle(
                              color:
                                  grocery.open
                                      ? Colors.green.shade800
                                      : kPrimaryRed,
                              fontWeight: FontWeight.w800,
                              fontSize: width * 0.04,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: AutoSizeText(
                        grocery.desc,
                        style: TextStyle(
                          fontSize: width * 0.033,
                          color: footerTextColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    const SizedBox(height: 3),

                    // Informations de livraison, heure, et note
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          spacing: width * 0.01,
                          children: [
                            Icon(
                              Icons.delivery_dining,
                              size: width * 0.06,
                              color: iconColor,
                            ),
                            Text(
                              "${grocery.deliveryPrice.toStringAsFixed(2)} DA",

                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.04,
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
                              Icons.access_time,
                              size: width * 0.06,
                              color: iconColor,
                            ),
                            Text(
                              parseTime(grocery.deliveryTime),
                              style: TextStyle(
                                fontSize: width * 0.04,
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
                              size: width * 0.06,
                              color: iconColor,
                            ),
                            Text(
                              grocery.rating.toString(),
                              style: TextStyle(
                                fontSize: width * 0.04,
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
