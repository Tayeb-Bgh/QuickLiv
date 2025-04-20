import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/constants/constants.dart';
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

    final Color footerBgColor = isDarkMode ? kSecondaryDark : kSecondaryWhite;
    final Color footerTxtColor = isDarkMode ? kLightGray : kDarkGray;
    final Color footerTitleColor = isDarkMode ? kSecondaryWhite : kPrimaryBlack;
    final Color bannerTxtColor = kPrimaryWhite;
    final Color iconColor = kPrimaryRed;

    return Container(
      width: width * 0.4,
      height: height * 0.35,
      decoration: BoxDecoration(
        color: footerBgColor,
        borderRadius: BorderRadius.circular(12),
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
                  width: double.infinity,
                  height: height * 0.15,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: GestureDetector(
                  onTap: () {}, // Replace with your action
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: iconColor, width: 2),
                    ),
                    child: Icon(Icons.add, color: iconColor, size: 20),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: -2,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: iconColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    product.nameBusns,
                    style: TextStyle(
                      fontSize: 10,
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
                    color: iconColor,
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
            padding: const EdgeInsets.fromLTRB(8, 6, 8, 2),
            child: Text(
              product.nameProd,
              style: TextStyle(
                color: footerTitleColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Text(
                  '${product.price} DZD',
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Row(
              children: [
                Text(
                  '${product.priceWithReduc} DZD',
                  style: TextStyle(
                    fontSize: 12,
                    color: iconColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Icon(Icons.access_time, size: 12, color: iconColor),
                SizedBox(width: 2),
                Text(
                  parseTime(product.delivDuration),
                  style: TextStyle(fontSize: 10, color: footerTxtColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
