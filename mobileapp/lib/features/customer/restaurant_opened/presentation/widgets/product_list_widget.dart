import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';
import 'package:mobileapp/features/customer/restaurant_opened/business/entities/product_entity.dart';
import 'package:mobileapp/features/customer/restaurant_opened/presentation/providers/restaurant_opened_provider.dart';
import 'package:mobileapp/features/customer/restaurant_opened/presentation/widgets/product_card.dart';
import 'package:mobileapp/features/customer/restaurant_opened/presentation/widgets/product_item_widget.dart';

class ProductListWidget extends ConsumerWidget {
  final int restaurantId;

  const ProductListWidget({Key? key, required this.restaurantId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final productsAsync = ref.watch(restaurantProductsProvider(restaurantId));


    return productsAsync.when(
      data: (products) {
        final filtered = selectedCategory == null
            ? products
            : products.where((p) => p.category == selectedCategory).toList();

        final Map<String, List<Product>> grouped = {};
        for (var p in filtered) {
          grouped.putIfAbsent(p.category, () => []).add(p);
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: grouped.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      capitalize( entry.key),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? kSecondaryWhite : kPrimaryBlack,
                      ),
                    ),
                  ),
                  // List of products
                  ...entry.value.map((product) => ProductListItem(product: product)).toList(), // <<< UTILISATION
                ],
              );
            }).toList(),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erreur: $e')),
    );
  }
}
