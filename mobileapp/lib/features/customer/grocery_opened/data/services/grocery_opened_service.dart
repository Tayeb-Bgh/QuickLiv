import 'package:dio/dio.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/customer/grocery_opened/data/models/product_business_model.dart';
import 'package:mobileapp/features/customer/grocery_opened/data/models/product_model.dart';

class GroceryOpenedService {
  final Dio dio;

  GroceryOpenedService({required this.dio});

  Future<List<ProductBusinessModel>> fetchGroceryProducts(int id) async {
    final String baseUrl = await ApiConfig.getBaseUrl();
    final String url = "$baseUrl/grocery-opened/$id/products";

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final List data = response.data;

        return data.map((json) => ProductBusinessModel.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to load grocery products: status ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductModel> fetchProductById(int id) async {
    final String baseUrl = await ApiConfig.getBaseUrl();
    final String url = "$baseUrl/grocery-opened/products/$id";

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data[0];

        return ProductModel.fromJson(data);
      } else {
        throw Exception(
          'Failed to load product: status ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>> fetchGroceryCateogries(int id) async {
    final String baseUrl = await ApiConfig.getBaseUrl();
    final String url = "$baseUrl/grocery-opened/$id/categories";

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        final List<String> categoryNames =
            data.map((e) => e['categoryProd'].toString()).toList();

        return categoryNames;
      } else {
        throw Exception(
          'Failed to load grocery categories: status ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>> fetchGrocerySecondCateogries(
    int id,
    String category,
  ) async {
    final String baseUrl = await ApiConfig.getBaseUrl();
    final String url =
        "$baseUrl/grocery-opened/$id/categories/$category/second-categories";

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        final List<String> secondCategories =
            data.map((e) => e['secondCategoryProd'].toString()).toList();

        return secondCategories;
      } else {
        throw Exception(
          'Failed to load grocery second categories: status ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
