

import 'package:mobileapp/features/customer/restaurant_opened/business/entities/product_entity.dart';

abstract class RestaurantOpenedRepository {
  Future<List<Product>> getProducts(int restaurantId);
}