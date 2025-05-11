import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/features/customer/grocery_opened/business/entities/product_entity.dart';

class MiniProductCard extends ConsumerWidget {
  final Product product;

  const MiniProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final bool isDarkMode = ref.watch(darkModeProvider);

    final Color footerBgColor = isDarkMode ? kSecondaryDark : kPrimaryWhite;
    final Color footerTitleColor = isDarkMode ? kSecondaryWhite : kPrimaryBlack;
    final Color iconColor = kPrimaryRed;

    return Container(
      width: width * 0.3,
      height: height * 0.3,
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
                  height: height * 0.08,
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
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.015),
            child: AutoSizeText(
              product.name,
              style: TextStyle(
                color: footerTitleColor,
                fontWeight: FontWeight.bold,
              ),
              minFontSize: 8,
              maxFontSize: 10,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: AutoSizeText(
              '${product.price.toStringAsFixed(2)} DZD',
              style: TextStyle(color: iconColor, fontWeight: FontWeight.bold),
              minFontSize: 10,
              maxFontSize: 12,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
