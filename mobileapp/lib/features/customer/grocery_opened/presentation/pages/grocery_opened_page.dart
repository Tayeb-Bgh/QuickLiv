import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/providers/grocery_opened_provider.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/widgets/fixed_top_bar.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/widgets/search_content.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/widgets/static_top_bar.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/widgets/vertical_list_of_prodcuts_list.dart';

class GroceryOpenedPage extends ConsumerWidget {
  const GroceryOpenedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);
    final height = MediaQuery.of(context).size.height;
    final bgColor = isDarkMode ? kPrimaryDark : kSecondaryWhite;
    final selectedCategories = ref.watch(selectedCategoriesProvider);
    final selectedSecondCategories = ref.watch(
      selectedSecondCategoriesProvider,
    );
    final secondCategoriesAsync = ref.watch(secondCategoriesProvider);

    final productsAsync = ref.watch(groceryProductsProvider);
    final List<String> secondCategories =
        selectedCategories.isEmpty
            ? secondCategoriesAsync.maybeWhen(
              data: (list) => list,
              orElse: () => [],
            )
            : selectedSecondCategories;

    final search = ref.read(searchTextProvider);

    return Scaffold(
      backgroundColor: bgColor,
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: CustomScrollView(
          slivers: [
            StaticTopBar(),
            FixedTopBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(bottom: height * 0.03),

                child:
                    search == ""
                        ? VerticalListOfProdcutsList(
                          products: productsAsync,
                          secondCategories: secondCategories,
                        )
                        : SearchContent(productsAsync: productsAsync),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
