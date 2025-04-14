import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapp/features/customer/groceries/data/models/business_model.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/customer/groceries/data/models/product_business_model.dart';
import 'package:mobileapp/features/customer/groceries/data/models/product_model.dart';

class GroceriesService {
  final Dio dio;

  GroceriesService(this.dio);

  Future<List<BusinessModel>> fetchGroceriesModelsByLocation(
    String wilaya,
    double lat,
    double lng,
  ) async {
    try {
      final url = await ApiConfig.getBaseUrl();

      final response = await dio.get("$url/groceries/?wilaya=béjaïa");

      if (response.statusCode == 200) {
        final List data = response.data;
        print(data[1]);
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

  Future<List<ProductModel>> fetctProcutsModelsForReductions() async {
    try {
      final url = await ApiConfig.getBaseUrl();

      final response = await dio.get("$url/groceries/reductions/products");

      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        throw Exception(
          'Failed to load groceries: status ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BusinessModel>> fetctBusinessModelsForReductions() async {
    try {
      final url = await ApiConfig.getBaseUrl();

      final response = await dio.get("$url/groceries/reductions/business");

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

  Future<List<ProductBusinessModel>>
  fetctProductsBusinessModelsForReductions() async {
    try {
      final url = await ApiConfig.getBaseUrl();

      final response = await dio.get(
        "$url/groceries/reductions/products-business",
      );

      if (response.statusCode == 200) {
        final List data = response.data;
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
}
