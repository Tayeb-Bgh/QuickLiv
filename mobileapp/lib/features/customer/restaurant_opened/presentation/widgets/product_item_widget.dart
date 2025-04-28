import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/restaurant_opened/business/entities/product_entity.dart';

class ProductListItem extends ConsumerWidget {
  final Product product;

  const ProductListItem({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        /* showDialog(
          context: context,
          builder: (_) => ProductCard(
            imgUrl: product.imgUrl,
            nameProd: product.name,
            descProd: product.desc,
            priceProd: '${product.price.toStringAsFixed(2)} DA',
          ),
        ); */
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        padding: const EdgeInsets.all(8),
        height: product.priceWithReduc != null ? 110 : 95, 
        decoration: BoxDecoration(
          color: isDarkMode ? kPrimaryDark : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: kPrimaryBlur,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.imgUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: kLightGrayWhite,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: kMediumGray,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? kSecondaryWhite : kPrimaryBlack,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    product.desc,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2, 
                    style: TextStyle(
                      fontSize: 11,
                      color: isDarkMode ? kLightGray : kMediumGray,
                    ),
                  ),
                  const Spacer(), 
                  Row(
                    children: [
                      product.priceWithReduc != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 16,),
                                    Text(
                                  '${product.price.toStringAsFixed(2)} DA',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDarkMode ? kLightGray : kMediumGray,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: isDarkMode ? kLightGrayWhite: kMediumGray,
                                    decorationThickness: 1.9,
                                  ),
                                ),
                                  ],
                                ),
                                
                                Text(
                                  '${product.priceWithReduc!.toStringAsFixed(2)} DA',
                                  style: TextStyle(
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryRed,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              '${product.price.toStringAsFixed(2)} DA',
                              style: TextStyle(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryRed,
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Bouton + indépendant avec marge
            GestureDetector(
              onTap: () {
                print('Ajouté au panier : ${product.name}');
              },
              child: Container(
                margin: const EdgeInsets.only(left: 8, top: 8), // Ajoute un peu d'espace
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: kPrimaryRed,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
