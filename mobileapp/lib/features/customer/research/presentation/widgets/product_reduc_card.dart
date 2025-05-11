import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';
import 'package:mobileapp/features/customer/research/business/entities/product_entity.dart';

class ProductReducCard extends ConsumerWidget {
  final Product product;

  const ProductReducCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final bool isDarkMode = ref.watch(darkModeProvider);

    final Color footerBgColor = isDarkMode ? kSecondaryDark : kPrimaryWhite;
    final Color footerTitleColor = isDarkMode ? kSecondaryWhite : kPrimaryBlack;
    final Color reducTxtColor = isDarkMode ? kLightGray : kDarkGray;
    final Color bannerTxtColor = kPrimaryWhite;
    final Color bannerColor = kPrimaryRed;
    final Color iconColor = isDarkMode ? kSecondaryWhite : kPrimaryRed;
    final Color btnBgColor = isDarkMode ? kSecondaryDark : kSecondaryWhite;

    return Container(
      width: width * 0.3,
      height: height * 0.36,
      decoration: BoxDecoration(
        color: footerBgColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: kPrimaryBlur,
            blurRadius: 1,
            offset: const Offset(0, 1),
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
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                child: Image.network(
                  product.imgUrl,
                  width: width * 0.3,
                  height: height * 0.1,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: GestureDetector(
                  onTap: () {}, // Replace with your action
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: btnBgColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: iconColor, width: 2),
                    ),
                    child: Icon(Icons.add, color: iconColor, size: 20),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: bannerColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
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
              product.name,
              style: TextStyle(
                color: footerTitleColor,
                fontWeight: FontWeight.bold,
                fontSize: width * 0.029,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${product.price} DZD',
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationThickness: 1,
                    decorationColor: reducTxtColor,
                    fontSize: width * 0.02,
                    color: reducTxtColor,
                  ),
                ),
                Text(
                  '${getPriceWithReduction(product.price, product.reducRate ?? 0)} DZD',
                  style: TextStyle(
                    fontSize: width * 0.035,
                    color: bannerColor,
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
