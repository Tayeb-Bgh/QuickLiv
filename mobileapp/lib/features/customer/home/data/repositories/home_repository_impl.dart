import 'dart:math';

import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/home/business/entities/product_reduc.dart';
import 'package:mobileapp/features/customer/home/data/models/product_business.dart';
import 'package:mobileapp/features/customer/home/data/models/product_model.dart';
import 'package:mobileapp/features/customer/home/data/service/home_service.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';

class HomeRepositoryImpl {
  final HomeService homeService;
  HomeRepositoryImpl({required this.homeService});

  Future<List<ProductReduc>> getBestReductions(
    List<Grocery> groceries,
    List<Restaurant> restaurants,
  ) async {
    final List<ProductReduc> productsList = [];
    final List<ProductBusinessModel> productsBusinessModels = [];
    List<ProductModel> productsModels = [];

    Future<void> loadBestReductions() async {
      final List<ProductBusinessModel> allResults = [];

      for (final g in groceries) {
        try {
          final results = await homeService.fetchBestReductions(g.id);

          allResults.addAll(results);
        } catch (e) {}
      }

      for (final r in restaurants) {
        try {
          final results = await homeService.fetchBestReductions(r.id);

          allResults.addAll(results);
        } catch (e) {}
      }

      productsBusinessModels.addAll(allResults);

      final List<ProductModel> fetchedProducts = [];
      for (final product in productsBusinessModels) {
        try {
          final productData = await homeService.getProductByid(product.idProd);
          fetchedProducts.add(productData);
        } catch (e) {}
      }

      productsModels = fetchedProducts;
    }

    await loadBestReductions();

    for (final ProductModel productModel in productsModels) {
      final ProductBusinessModel correspondingProduct = productsBusinessModels
          .firstWhere((p) => p.idProd == productModel.idProd);

      final int idBusiness = correspondingProduct.idBusns;
      final double reductionRate = correspondingProduct.reducRateProdBusns;

      final Grocery? grocery =
          groceries.where((g) => g.id == idBusiness).firstOrNull;
      final Restaurant? restaurant =
          restaurants.where((r) => r.id == idBusiness).firstOrNull;

      print("grocery : $grocery restaurant: $restaurant");

      final ProductReduc product = productModel.toEntity(
        grocery,
        restaurant,
        reductionRate,
      );
      productsList.add(product);
    }

    productsList.shuffle(Random());
    return productsList.take(3).toList();
  }
}
