import 'package:mobileapp/features/customer/grocery_opened/business/repositories/grocery_opened_repository.dart';
import 'package:mobileapp/features/customer/grocery_opened/data/services/grocery_opened_service.dart';
import 'package:mobileapp/features/customer/grocery_opened/business/entities/product_entity.dart';
import 'package:mobileapp/features/customer/grocery_opened/data/models/product_model.dart';

class GroceryOpenedRepositoryImpl implements GroceryOpenedRepository {
  final GroceryOpenedService groceryOpenedService;
  GroceryOpenedRepositoryImpl({required this.groceryOpenedService});

  Future<List<Product>> getProducts(int idGroc) async {
    final productBusinessList = await groceryOpenedService.fetchGroceryProducts(
      idGroc,
    );

    final List<Product> productsList = [];

    for (final product in productBusinessList) {
      final ProductModel productModel = await groceryOpenedService
          .fetchProductById(product.idProd);
      final int idBusns = product.idBusns;
      final bool unit = productModel.unitProd;
      final double price = product.priceProdBusns;
      final double? reducRate = product.reducRateProdBusns;
      final int? stockQtty = product.qttyProdBusns;

      productsList.add(
        productModel.toEntity(idBusns, price, unit, reducRate, stockQtty),
      );
    }

    return productsList;
  }

  Future<List<String>> getCategories(int idGroc) async {
    List<String> categories = await groceryOpenedService.fetchGroceryCateogries(
      idGroc,
    );

    return categories;
  }

  Future<List<String>> getSecondCategories(int idGrod, String category) async {
    final String parsedCategory = category.replaceAll(" ", "-");
    final List<String> secondCategories = await groceryOpenedService
        .fetchGrocerySecondCateogries(idGrod, parsedCategory);

    return secondCategories;
  }
}
