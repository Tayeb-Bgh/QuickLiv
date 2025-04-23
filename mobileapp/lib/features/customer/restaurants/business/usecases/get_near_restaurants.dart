import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';
import 'package:mobileapp/features/customer/restaurants/data/repositories/restaurants_repository_impl.dart';

class GetNearRestaurants {
  final RestaurantsRepositoryImpl restaurantsRepositoryImpl;

  GetNearRestaurants({required this.restaurantsRepositoryImpl});

  Future<List<Restaurant>> call(String wilaya, double lat, double lng) {
    return restaurantsRepositoryImpl.getRestaurants(wilaya, lat, lng);
  }
}
