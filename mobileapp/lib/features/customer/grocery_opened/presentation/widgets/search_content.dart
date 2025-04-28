import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/grocery_opened/business/entities/product_entity.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/providers/grocery_opened_provider.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/widgets/mini_product_card.dart';

class SearchContent extends ConsumerWidget {
  final AsyncValue<List<Product>> productsAsync;
  const SearchContent({super.key, required this.productsAsync});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkeMode = ref.watch(darkModeProvider);
    final txtCol = isDarkeMode ? kSecondaryWhite : kPrimaryBlack;
    final width = MediaQuery.of(context).size.width;
    final search = ref.watch(searchTextProvider); // .watch au lieu de .read
    return productsAsync.when(
      data: (products) {
        final filteredProds = ref
            .watch(searchProductsProvider)
            .call(products, search);

        if (filteredProds.isEmpty) {
          return Center(
            child: Text(
              "Aucun résultat trouvé",
              style: TextStyle(color: txtCol),
            ),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(
            top: 10,
            left: width * kDefaultPadding,
            right: width * kDefaultPadding,
            bottom: 10,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: filteredProds.length,
          itemBuilder: (context, index) {
            final product = filteredProds[index];
            return MiniProductCard(product: product);
          },
        );
      },
      error: (error, _) {
        return Center(
          child: Text(
            "Une erreur est survenue",
            style: TextStyle(color: txtCol),
          ),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(color: kPrimaryRed),
        );
      },
    );
  }
}
