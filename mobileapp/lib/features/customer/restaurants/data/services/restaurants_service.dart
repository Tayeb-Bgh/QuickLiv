import 'package:dio/dio.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/customer/restaurants/data/models/business_model.dart';
import 'package:mobileapp/features/customer/restaurants/data/models/product_business_model.dart';
import 'package:mobileapp/features/customer/restaurants/data/models/product_model.dart';

class RestaurantsService {
  final Dio dio;

  RestaurantsService(this.dio);

  Future<List<BusinessModel>> fetchRestaurantsModelsByLocation(
    String wilaya,
    double lat,
    double lng,
    String? category,
  ) async {
    try {
      final url = await ApiConfig.getBaseUrl();
      String urlWithOptions = "$url/restaurants/?wilaya=béjaïa";
      urlWithOptions += category != null ? "&category=$category" : "";
      final response = await dio.get(urlWithOptions);

      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((e) => BusinessModel.fromJson(e)).toList();
      } else {
        throw Exception(
          'Failed to load groceries: status ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductBusinessModel>> fetchProductsOfRestaurant(
    int idBusns,
  ) async {
    try {
      final url = await ApiConfig.getBaseUrl();
      String urlWithOptions = "$url/restaurants/products-business/$idBusns";

      final response = await dio.get(urlWithOptions);
      if (response.statusCode == 200) {
        final List data = response.data;
        print(data);
        return data.map((e) => ProductBusinessModel.fromJson(e)).toList();
      } else {
        throw Exception(
          'Failed to load groceries: status ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductModel> fetchProductById(int idProd) async {
    try {
      final url = await ApiConfig.getBaseUrl();

      String urlWithOptions = "$url/restaurants/products/$idProd";

      final response = await dio.get(urlWithOptions);

      if (response.statusCode == 200) {
        final data = response.data[0];
        return Future.value(ProductModel.fromJson(data));
      } else {
        throw Exception(
          'Failed to load groceries: status ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
