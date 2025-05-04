import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/pages/grocery_opened_page.dart';
import 'package:mobileapp/features/customer/research/business/entities/business_entity.dart';
import 'package:mobileapp/features/customer/research/presentation/widgets/business_informations.dart';
import 'package:mobileapp/features/customer/research/presentation/widgets/business_products_list.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/providers/grocery_opened_provider.dart';
import 'package:mobileapp/features/customer/groceries/presentation/providers/groceries_provider.dart';
import 'package:mobileapp/features/customer/restaurant_opened/presentation/pages/restaurant_opened_page.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';

class BusinessProducts extends ConsumerWidget {
  final Business business;
  const BusinessProducts({super.key, required this.business});

  void onTap(BuildContext context, WidgetRef ref, String type) {
    if (type == 'grocery') {
      ref.read(searchTextProvider.notifier).state = "";
      ref.watch(selectedCategoriesProvider.notifier).state = [];
      ref.watch(selectedSecondCategoriesProvider.notifier).state = [];
      ref.watch(selectedCategoryProvider.notifier).state = null;
      ref.watch(selectedSecondCategoryProvider.notifier).state = null;

      ref.read(selectedGroceryProvider.notifier).state = Grocery(
        id: business.id,
        name: business.name,
        category: "",
        description: business.description,
        imgUrl: business.imgUrl,
        vidUrl: business.vidUrl,
        delivPrice: business.delivPrice,
        delivTime: business.delivDuration,
        rating: business.rating,
        liked: false,
        distance: 1231312,
      );

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
            (_) => RestaurantBottomSheet(
              restaurant: Restaurant(
                id: business.id,
                name: business.name,
                category: "",
                description: business.description,
                imgUrl: business.imgUrl,
                vidUrl: business.vidUrl,
                delivPrice: business.delivPrice,
                delivTime: business.delivDuration,
                rating: business.rating,
                liked: false,
                distance: business.distance,
              ),
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        final String type = business.type;
        onTap(context, ref, type);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: kPrimaryBlur,
              offset: Offset(0, 1),
              blurStyle: BlurStyle.normal,
              blurRadius: 3,
            ),
          ],
        ),
        child: Column(
          children: [
            BusinessInformations(business: business),
            BusinessProductsList(products: business.products),
          ],
        ),
      ),
    );
  }
}
