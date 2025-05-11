import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/groceries/presentation/providers/groceries_provider.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/pages/grocery_opened_page.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/providers/grocery_opened_provider.dart';
import 'package:mobileapp/features/customer/research/business/entities/business_entity.dart';
import 'package:mobileapp/features/customer/restaurant_opened/presentation/pages/restaurant_opened_page.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';

class BusinessInformations extends ConsumerWidget {
  final Business business;
  const BusinessInformations({super.key, required this.business});

  void onTap(BuildContext context, WidgetRef ref, String type) {
    if (type == 'grocery') {
      ref.read(searchTextProvider.notifier).state = "";
      ref.watch(selectedCategoriesProvider.notifier).state = [];
      ref.watch(selectedSecondCategoriesProvider.notifier).state = [];
      ref.watch(selectedCategoryProvider.notifier).state = null;
      ref.watch(selectedSecondCategoryProvider.notifier).state = null;

      ref.read(selectedGroceryProvider.notifier).state = Grocery(
        id: business.id,
        name: business.name,
        category: "",
        description: business.description,
        imgUrl: business.imgUrl,
        vidUrl: business.vidUrl,
        delivPrice: business.delivPrice,
        delivTime: business.delivDuration,
        rating: business.rating,
        liked: false,
        distance: business.distance,
        insta: business.insta,
        fcb: business.fcb,
        phone: business.phone,
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GroceryOpenedPage()),
      );
    } else {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        isScrollControlled: true,
        builder:
            (_) => RestaurantBottomSheet(
              restaurant: Restaurant(
                id: business.id,
                name: business.name,
                category: "",
                description: business.description,
                imgUrl: business.imgUrl,
                vidUrl: business.vidUrl,
                delivPrice: business.delivPrice,
                delivTime: business.delivDuration,
                rating: business.rating,
                liked: false,
                distance: business.distance,
                insta: business.insta,
                fcb: business.fcb,
                phone: business.phone,
              ),
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;

    final isDarkMode = ref.watch(darkModeProvider);
    final Color starColor = kPrimaryRed;
    final Color strokeColor = isDarkMode ? kPrimaryWhite : kPrimaryRed;
    final Color bgColor = isDarkMode ? kSecondaryDark : kWhiteGray;
    final Color busnsNameColor = isDarkMode ? kSecondaryWhite : kPrimaryBlack;
    final Color additionnalInfosColor = isDarkMode ? kLightGray : kMediumGray;

    final double minTitleSize = 18;
    final double maxTitleSize = 20;
    final double additionalInfosMinSize = 10;
    final double additionalInfosMaxSize = 12;
    final double seeMenuMinSize = 10;
    final double seeMenuMaxSize = 12;

    final Color isOpenTxtColor = kPrimaryGreen;
    final Color isOpenBgColor = kPrimaryGreen.withOpacity(0.2);

    final Color isCloseTxtColor = kPrimaryRed;
    final Color isCloseBgColor = kPrimaryRed.withOpacity(0.2);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Row(
        children: [
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: strokeColor,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: strokeColor, width: 3),
                  ),
                  margin: EdgeInsets.only(right: 5),
                  child: ClipOval(
                    child: Image.network(
                      business.imgUrl,
                      width: width * 0.15,
                      height: width * 0.15,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        business.name,
                        style: TextStyle(
                          color: busnsNameColor,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        minFontSize: minTitleSize,
                        maxFontSize: maxTitleSize,
                        maxLines: 1,
                      ),
                      AutoSizeText(
                        "Frais de livraison: ${business.delivPrice.toStringAsFixed(2)} DZD",
                        style: TextStyle(color: additionnalInfosColor),
                        minFontSize: additionalInfosMinSize,
                        maxFontSize: additionalInfosMaxSize,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: starColor, size: 12),
                          SizedBox(width: 4),
                          Expanded(
                            child: AutoSizeText(
                              "${business.rating} Durée estimée: ${Business.parseDelivDuration(business.delivDuration)}",
                              style: TextStyle(color: additionnalInfosColor),
                              maxFontSize: additionalInfosMaxSize,
                              minFontSize: additionalInfosMinSize,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(5), // 👈 No padding at all
                  minimumSize: Size(
                    0,
                    0,
                  ), // 👈 Optional: remove min size constraints
                  tapTargetSize:
                      MaterialTapTargetSize.shrinkWrap, // 👈 Reduce touch area
                ),
                onPressed: () => onTap(context, ref, business.type),
                child: Row(
                  children: [
                    AutoSizeText(
                      "Voir le Menu",
                      style: TextStyle(
                        color: additionnalInfosColor,
                        fontWeight: FontWeight.w700,
                      ),
                      minFontSize: seeMenuMinSize,
                      maxFontSize: seeMenuMaxSize,
                      maxLines: 1,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: additionnalInfosColor,
                      size: 14,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: business.open ? isOpenBgColor : isCloseBgColor,
                  border: Border.all(
                    color: business.open ? isOpenTxtColor : isCloseTxtColor,
                    width: 1.5,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: AutoSizeText(
                  business.open ? "Ouvert" : "Fermé",
                  style: TextStyle(
                    color: business.open ? isOpenTxtColor : isCloseTxtColor,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  minFontSize: additionalInfosMinSize,
                  maxFontSize: additionalInfosMaxSize,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
