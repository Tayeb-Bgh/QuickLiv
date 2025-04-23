import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/product_entity.dart';

abstract class RestaurantsRepository {
  Future<List<Restaurant>> getRestaurants(
    String wilaya,
    double lat,
    double lng,
  );
  Future<List<Restaurant>> getRestaurantsByCategory(
    String wilaya,
    double lat,
    double lng,
    String category,
  );
  Future<List<Product>> getBestProducts(List<Restaurant> restaurants);
}
