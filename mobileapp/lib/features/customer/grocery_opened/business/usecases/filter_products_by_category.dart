import 'package:mobileapp/features/customer/grocery_opened/business/entities/product_entity.dart';

class FilterProductsByCategory {
  List<Product> call(List<Product> products, String? secondCateogry) {
    if (secondCateogry == null) return products;

    return products
        .where((prod) => prod.secondCategory == secondCateogry)
        .toList();
  }
}
