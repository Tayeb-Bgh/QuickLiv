import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/grocery_opened/business/entities/product_entity.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/providers/grocery_opened_provider.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/widgets/products_list_view.dart';

class VerticalListOfProdcutsList extends ConsumerWidget {
  final AsyncValue<List<Product>> products;
  final List<String> secondCategories;
  final isFull = true;

  const VerticalListOfProdcutsList({
    super.key,
    required this.products,
    required this.secondCategories,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    final bgColor = isDarkMode ? kPrimaryDark : kSecondaryWhite;

    return Container(
      color: bgColor,
      padding: EdgeInsets.only(bottom: 12, left: 12),
      child: products.when(
        data:
            (products) => Column(
              children:
                  secondCategories.map((category) {
                    final filteredProds = ref
                        .watch(filterProductsByCategoryProvider)
                        .call(products, category);

                    return ProductsListView(
                      products: filteredProds,
                      title: category,
                    );
                  }).toList(),
            ),
        error: (err, _) => const Text('Une erreur est survenue'),
        loading:
            () => const Center(
              child: CircularProgressIndicator(color: kPrimaryRed),
            ),
      ),
    );
  }
}
