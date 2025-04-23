import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';
import 'package:mobileapp/features/customer/restaurants/data/repositories/restaurants_repository_impl.dart';

class GetNearRestaurantsByCategory {
  final RestaurantsRepositoryImpl restaurantsRepositoryImpl;

  GetNearRestaurantsByCategory({required this.restaurantsRepositoryImpl});

  Future<List<Restaurant>> call(
    String wilaya,
    double lat,
    double lng,
    String? category,
  ) {
    return restaurantsRepositoryImpl.getRestaurantsByCategory(
      wilaya,
      lat,
      lng,
      category,
    );
  }
}
