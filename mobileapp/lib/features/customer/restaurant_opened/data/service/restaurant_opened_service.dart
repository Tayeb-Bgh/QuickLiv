import 'package:dio/dio.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';

class RestaurantOpenedService {
  final Dio dio;

  RestaurantOpenedService(this.dio);

 Future<List<String>> fetchCategories(int restaurantId) async {
  String baseUrl = await ApiConfig.getBaseUrl();
  final response = await dio.get(
    '$baseUrl/restaurant-opened/$restaurantId/categories',
  );

  final List<Map<String, dynamic>> data =
      List<Map<String, dynamic>>.from(response.data);

  final List<String> categories =
      data.map((item) => item['secondCategoryProd'] as String).toList();

  return categories;
}

}
