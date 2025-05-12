import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/product_entity.dart';
import 'package:mobileapp/features/customer/restaurants/presentation/widgets/best_product_card.dart';

class BestProductsListView extends ConsumerStatefulWidget {
  final AsyncValue<List<Product>> bestProducts;
  final String title = "Nos meilleurs produits";

  final Function onRefresh;
  final isFull = false;
  const BestProductsListView({
    super.key,
    required this.bestProducts,
    required this.onRefresh,
  });
  @override
  ConsumerState<BestProductsListView> createState() =>
      _BestProductsListViewState();
}

class _BestProductsListViewState extends ConsumerState<BestProductsListView> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToNextItem() {
    if (_scrollController.hasClients) {
      final cardWidth = MediaQuery.of(context).size.width * 0.39;

      final nextPosition = _scrollController.offset + cardWidth + 10;
      _scrollController.animateTo(
        nextPosition,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final isDarkMode = ref.watch(darkModeProvider);

    final Color titleColor = isDarkMode ? kSecondaryWhite : kPrimaryRed;
    final Color btnBgColor = isDarkMode ? kSecondaryWhite : kPrimaryRed;
    final Color btnIconColor = isDarkMode ? kPrimaryBlack : kPrimaryWhite;

    return ColoredBox(
      color: isDarkMode ? kPrimaryDark : kSecondaryWhite,
      child: Container(
        padding: EdgeInsets.only(left: width * kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.title,
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
                  onPressed: _scrollToNextItem,
                  icon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: btnBgColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: btnIconColor,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.006),
            widget.bestProducts.when(
              data:
                  (bestProducts) => RefreshIndicator(
                    onRefresh: () => widget.onRefresh(),
                    child: SizedBox(
                      height: height * 0.203,
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: bestProducts.length,
                        itemBuilder: (context, index) {
                          final product = bestProducts[index];
                          return Container(
                            margin: EdgeInsets.only(
                              right: 10,
                              bottom: height * 0.008,
                            ),
                            child: BestProductCard(product: product),
                          );
                        },
                      ),
                    ),
                  ),
              error: (err, _) => Text('errooor'),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}