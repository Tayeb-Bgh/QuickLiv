import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/research/business/entities/product_entity.dart';
import 'package:mobileapp/features/customer/research/presentation/widgets/product_card.dart';
import 'package:mobileapp/features/customer/research/presentation/widgets/product_reduc_card.dart';

class BusinessProductsList extends ConsumerWidget {
  final List<Product> products;
  const BusinessProductsList({super.key, required this.products});

  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);
    final Color bgColor = isDarkMode ? kPrimaryBlack : kPrimaryWhite;
    final height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),

      padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
      child: Container(
        height: height * 0.175, // or whatever height fits your product cards
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) {
            final Product product = products[index];
            return Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.symmetric(vertical: 5),

              child:
                  product.reducRate == null
                      ? ProductCard(product: product)
                      : ProductReducCard(product: product),
            );
          },
        ),
      ),
    );
  }
}
