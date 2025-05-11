import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/cart_popup/presentation/providers/cart_provider.dart';
import 'package:mobileapp/features/customer/cart_popup/presentation/widgets/pop_ups.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/product_with_reduc_entity.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';

class ProductReducCard extends ConsumerWidget {
  final ProductWithReduc product;

  const ProductReducCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final bool isDarkMode = ref.watch(darkModeProvider);

    final Color footerBgColor = isDarkMode ? kSecondaryDark : kPrimaryWhite;
    final Color footerTxtColor = isDarkMode ? kLightGray : kDarkGray;
    final Color footerTitleColor = isDarkMode ? kSecondaryWhite : kPrimaryBlack;
    final Color reducTxtColor = isDarkMode ? kLightGray : kDarkGray;
    final Color bannerTxtColor = kPrimaryWhite;
    final Color iconColor = isDarkMode ? kSecondaryWhite : kPrimaryRed;
    final Color bannerBgColor = kPrimaryRed;
    final Color buttonBgColor = isDarkMode ? kSecondaryDark : kSecondaryWhite;

    return Container(
      width: width * 0.39,
      height: height * 0.36,
      decoration: BoxDecoration(
        color: footerBgColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: kPrimaryBlur,
            blurRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  product.imgUrl,
                  width: width * 0.39,
                  height: height * 0.13,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: GestureDetector(
                  onTap: () async {
                    product.unit
                        ? showQuantityWithUnitSelectorDialog(
                          context,
                          ref,
                          productWithRed: product,
                        )
                        : showQuantitySelectorDialog(
                          context,
                          ref,
                          productWithRed: product,
                        );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: buttonBgColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: iconColor, width: 2),
                    ),
                    child: Icon(Icons.add, color: iconColor, size: 20),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: -2,
                width: width * 0.25,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: bannerBgColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    product.nameBusns,
                    style: TextStyle(
                      fontSize: width * 0.025,
                      color: bannerTxtColor,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: bannerBgColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    "-${product.reducRate}%",
                    style: TextStyle(
                      fontSize: 10,
                      color: bannerTxtColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.015),
            child: Text(
              product.nameProd,
              style: TextStyle(
                color: footerTitleColor,
                fontWeight: FontWeight.bold,
                fontSize: width * 0.029,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.065,
              vertical: 0,
            ),
            child: Row(
              children: [
                Text(
                  '${product.price.toStringAsFixed(2)} DZD',
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationThickness:
                        1, // Augmentez cette valeur pour un trait plus épais
                    decorationColor: reducTxtColor,
                    fontSize: width * 0.029,
                    color: reducTxtColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: Row(
              children: [
                Text(
                  '${product.priceWithReduc.toStringAsFixed(2)} DZD',
                  style: TextStyle(
                    fontSize: 12,
                    color: bannerBgColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Icon(Icons.timer, size: 11, color: iconColor),
                SizedBox(width: 1.9),
                Text(
                  parseTime(product.delivDuration),
                  style: TextStyle(
                    fontSize: 8,
                    color: footerTxtColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
