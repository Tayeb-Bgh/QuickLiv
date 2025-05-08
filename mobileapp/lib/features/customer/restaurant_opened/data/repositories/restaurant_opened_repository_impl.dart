import 'package:mobileapp/features/customer/restaurant_opened/business/entities/product_entity.dart';
import 'package:mobileapp/features/customer/restaurant_opened/business/repositories/restaurant_opened.dart';
import 'package:mobileapp/features/customer/restaurant_opened/data/models/product_model.dart';
import 'package:mobileapp/features/customer/restaurant_opened/data/service/restaurant_opened_service.dart';

class RestaurantOpenedRepositoryImpl implements RestaurantOpenedRepository {
  final RestaurantOpenedService service;

  RestaurantOpenedRepositoryImpl(this.service);

  @override
  Future<List<Product>> getProducts(int restaurantId) async {
    final List<ProductModel> response = await service.fetchProducts(
      restaurantId,
    );
    return response.map((model) => model.toEntity(restaurantId)).toList();
  }
}
