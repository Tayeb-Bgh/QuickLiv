import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';
import 'package:mobileapp/features/customer/grocery_opened/business/entities/product_entity.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/providers/grocery_opened_provider.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/widgets/product_card.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/widgets/products_grid.dart';

class ProductsListView extends ConsumerWidget {
  final List<Product> products;
  final String title;

  //final Function onRefresh;
  final isFull = false;
  const ProductsListView({
    super.key,
    required this.products,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final isDarkMode = ref.watch(darkModeProvider);
    final Color titleColor = isDarkMode ? kSecondaryWhite : kPrimaryRed;
    final Color btnBgColor = isDarkMode ? kSecondaryWhite : kPrimaryRed;
    final Color btnIconColor = isDarkMode ? kPrimaryBlack : kPrimaryWhite;

    final secCategoriesMap = ref.watch(secondCateogriesMapProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              capitalize(title),
              textAlign: TextAlign.left,
              style: TextStyle(
                color: titleColor,
                fontWeight: FontWeight.bold,
                fontSize: width * 0.060,
              ),
            ),

            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                ref.watch(selectedSecondCategoryProvider.notifier).state =
                    products[0].secondCategory;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ProductsGrid(
                          productsAsync: ref.watch(groceryProductsProvider),
                          category: products[0].category,
                          secondCategories: secCategoriesMap.when(
                            data: (data) {
                              final key = products[0].category;
                              return data[key] ?? [];
                            },
                            error: (_, __) => [],
                            loading: () => [],
                          ),
                        ),
                  ),
                );
              },
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: btnBgColor,
                  shape:
                      BoxShape
                          .circle, // ou BorderRadius.circular(...) si tu préfères
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: btnIconColor,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.006),
        SizedBox(
          height: height * 0.16,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Container(
                margin: EdgeInsets.only(right: 10, bottom: height * 0.008),
                child: ProductCard(product: product),
              );
            },
          ),
        ),
      ],
    );
  }
}
