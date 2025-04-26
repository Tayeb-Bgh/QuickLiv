
import 'package:mobileapp/features/customer/restaurant_opened/business/entities/product_entity.dart';
import 'package:mobileapp/features/customer/restaurant_opened/business/repositories/restaurant_opened.dart';

class GetProductsUsecase {
  final RestaurantOpenedRepository repository;

  GetProductsUsecase(this.repository);

  Future<List<Product>> call(int restaurantId) {
    return repository.getProducts(restaurantId);
  }
}
