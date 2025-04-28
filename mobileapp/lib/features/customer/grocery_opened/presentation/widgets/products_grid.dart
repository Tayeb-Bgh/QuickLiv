import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/grocery_opened/business/entities/product_entity.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/providers/grocery_opened_provider.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/widgets/filters_radio_buttons.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/widgets/mini_product_card.dart';

class ProductsGrid extends ConsumerWidget {
  final String category;
  final List<String> secondCategories;
  final AsyncValue<List<Product>> productsAsync;

  ProductsGrid({
    super.key,
    required this.category,
    required this.secondCategories,
    required this.productsAsync,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);
    final titleCol = kSecondaryWhite;
    final appBarBgColor = kPrimaryRed;
    final bgColor = isDarkMode ? kPrimaryDark : kSecondaryWhite;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true, // Centre le titre
        title: Text(
          category,
          style: TextStyle(color: titleCol, fontWeight: FontWeight.bold),
        ),
        backgroundColor: appBarBgColor,
        iconTheme: IconThemeData(
          color: titleCol, // Change la couleur de la flèche de retour
        ),
      ),
      body: productsAsync.when(
        data: (products) {
          final String? secondCategory = ref.watch(
            selectedSecondCategoryProvider,
          );
          var filteredProds = ref
              .watch(filterProductsByCategoryProvider)
              .call(products, secondCategory);
          filteredProds =
              filteredProds.where((p) => p.category == category).toList();
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: FiltersRadioButtons(categories: secondCategories),
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: width * kDefaultPadding,
                    right: width * kDefaultPadding,
                    bottom: 20,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        3, // Adjust to your need (e.g., 2 items per row)
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: filteredProds.length,
                  itemBuilder: (context, index) {
                    final product = filteredProds[index];
                    return MiniProductCard(product: product);
                  },
                ),
              ),
            ],
          );
        },
        error: (error, _) {},
        loading: () {},
      ),
    );
  }
}
