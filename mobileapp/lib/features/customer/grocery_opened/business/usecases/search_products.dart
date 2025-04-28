import 'package:mobileapp/features/customer/grocery_opened/business/entities/product_entity.dart';

class SearchProducts {
  List<Product> call(List<Product> products, String keyWord) {
    return products
        .where(
          (prod) => prod.name.toLowerCase().trim().contains(
            keyWord.trim().toLowerCase(),
          ),
        )
        .toList();
  }
}
