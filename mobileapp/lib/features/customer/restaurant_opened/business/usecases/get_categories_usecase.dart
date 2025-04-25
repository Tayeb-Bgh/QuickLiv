
import 'package:mobileapp/features/customer/restaurant_opened/data/service/restaurant_opened_service.dart';

class GetCategoriesUseCase {
  final RestaurantOpenedService service;

  GetCategoriesUseCase(this.service);

  Future<List<String>> call(int restaurantId) {
    return service.fetchCategories(restaurantId);
  }
}
