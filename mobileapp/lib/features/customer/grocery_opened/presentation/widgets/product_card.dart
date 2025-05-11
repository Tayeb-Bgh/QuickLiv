import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/features/customer/cart_popup/presentation/widgets/pop_ups.dart';
import 'package:mobileapp/features/customer/grocery_opened/business/entities/product_entity.dart';

class ProductCard extends ConsumerWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final bool isDarkMode = ref.watch(darkModeProvider);

    final Color footerBgColor = isDarkMode ? kSecondaryDark : kPrimaryWhite;
    final Color footerTitleColor = isDarkMode ? kSecondaryWhite : kPrimaryBlack;
    final Color priceTxtColor = kPrimaryRed;
    final Color iconColor = isDarkMode ? kSecondaryWhite : kPrimaryRed;
    final Color buttonBgColor = isDarkMode ? kSecondaryDark : kSecondaryWhite;

    return Container(
      width: width * 0.34,
      height: height * 0.32,
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
                  width: width * 0.34,
                  height: height * 0.1,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: GestureDetector(
                  onTap: () {
                    product.unit
                        ? showQuantityWithUnitSelectorDialog(
                          context,
                          ref,
                          product: product,
                        )
                        : showQuantitySelectorDialog(
                          context,
                          ref,
                          product: product,
                        );
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: buttonBgColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: iconColor, width: 2),
                    ),
                    child: Icon(Icons.add, color: iconColor, size: 20),
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

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: Text(
              '${product.price.toStringAsFixed(2)} DZD',
              style: TextStyle(
                fontSize: width * 0.035,
                color: priceTxtColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
