import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/features/customer/groceries/presentation/providers/groceries_provider.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/pages/grocery_opened_page.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/providers/grocery_opened_provider.dart';
import 'package:mobileapp/features/customer/home/business/entities/product_reduc.dart';
import 'package:mobileapp/features/customer/restaurant_opened/presentation/pages/restaurant_opened_page.dart';

class AdvertisementCard extends ConsumerWidget {
  final ProductReduc product;

  AdvertisementCard({super.key, required this.product});

  final List<String> promoPhrases = [
    "Découvrez notre délicieux nouveau plat !",
    "Laissez-vous tenter par notre création gourmande.",
    "Goûtez à l'excellence culinaire dès aujourd'hui.",
    "Un nouveau plat à savourer absolument !",
    "Craquez pour notre recette du moment.",
    "Une explosion de saveurs vous attend.",
    "Ne manquez pas notre dernière spécialité !",
    "Votre prochain coup de cœur gustatif est ici.",
    "Savourez la nouveauté du chef.",
    "Un goût inédit à découvrir sans plus attendre.",
    "Laissez vos papilles voyager avec notre nouveauté.",
    "Un plat unique, une expérience inoubliable.",
    "Essayez notre nouveauté, vous allez adorer !",
    "La gourmandise à l’état pur vient d’arriver.",
    "Une nouvelle sensation culinaire vous attend.",
  ];
  String getRandomPromoPhrase() {
    final random = Random();
    return promoPhrases[random.nextInt(promoPhrases.length)];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);

    return GestureDetector(
      onTap: () {
        if (product.grocery != null) {
          ref.read(searchTextProvider.notifier).state = "";
          ref.watch(selectedCategoriesProvider.notifier).state = [];
          ref.watch(selectedSecondCategoriesProvider.notifier).state = [];
          ref.watch(selectedCategoryProvider.notifier).state = null;
          ref.watch(selectedSecondCategoryProvider.notifier).state = null;

          ref.read(selectedGroceryProvider.notifier).state = product.grocery;

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
                (_) => RestaurantBottomSheet(restaurant: product.restaurant!),
          );
        }
      },
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width =
                constraints.maxWidth > 600
                    ? 500.0
                    : MediaQuery.of(context).size.width * 0.85;
            final double height = 150;

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: SizedBox(
                width: width,
                height: height,
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.4,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              color: Colors.red,
                              padding: EdgeInsets.all(width * 0.04),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    getRandomPromoPhrase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * 0.04,
                                    ),
                                    maxLines: 3,
                                    minFontSize: 10,
                                  ),
                                  const SizedBox(height: 10),
                                  AutoSizeText(
                                    '${product.reducRateProd}% OFF',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * 0.07,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    minFontSize: 18,
                                  ),
                                ],
                              ),
                            ),

                            Positioned(
                              top: -20,
                              right: 10,
                              child: CircleAvatar(
                                radius: width * 0.06,
                                backgroundColor: Colors.amber,
                                child: CircleAvatar(
                                  radius: width * 0.045,
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -10,
                              left: -10,
                              child: CircleAvatar(
                                radius: width * 0.06,
                                backgroundColor: Colors.amber,
                                child: CircleAvatar(
                                  radius: width * 0.045,
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Right image side
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        child: Image.network(
                          '${product.imgUrlProd}',
                          fit: BoxFit.cover,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
