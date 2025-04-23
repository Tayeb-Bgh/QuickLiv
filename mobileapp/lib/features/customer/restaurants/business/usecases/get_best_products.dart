import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/product_entity.dart';
import 'package:mobileapp/features/customer/restaurants/data/repositories/restaurants_repository_impl.dart';

class GetBestProducts {
  final RestaurantsRepositoryImpl repositoryImpl;

  GetBestProducts({required this.repositoryImpl});

  Future<List<Product>> call(List<Restaurant> retaurants) async {
    return await repositoryImpl.getBestProducts(retaurants);
  }
}
