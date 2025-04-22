import 'package:dio/dio.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/customer/groceries/data/models/business_model.dart';
import 'package:mobileapp/features/customer/groceries/data/models/product_business_model.dart';
import 'package:mobileapp/features/customer/groceries/data/models/product_model.dart';

class GroceriesService {
  final Dio dio;

  GroceriesService(this.dio);

  Future<List<BusinessModel>> fetchGroceriesModelsByLocation(
    String wilaya,
    double lat,
    double lng,
    String? category,
  ) async {
    try {
      final url = await ApiConfig.getBaseUrl();
      String urlWithOptions = "$url/groceries/?wilaya=béjaïa";
      urlWithOptions += category != null ? "&category=$category" : "";
      final response = await dio.get(urlWithOptions);

      print("GROCERIES BY LOCATION STATUS CODE ${response.statusCode}");

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

  Future<List<ProductBusinessModel>> fetchReductionsOfGrocey(
    int idBusns,
  ) async {
    try {
      final url = await ApiConfig.getBaseUrl();
      String urlWithOptions =
          "$url/groceries/reductions/products-business/$idBusns";

      final response = await dio.get(urlWithOptions);
      if (response.statusCode == 200) {
        final List data = response.data;
        final List dataMapped =
            data.map((e) => ProductBusinessModel.fromJson(e)).toList();

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

      String urlWithOptions = "$url/groceries/products/$idProd";

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
