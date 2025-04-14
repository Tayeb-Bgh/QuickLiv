import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapp/features/customer/groceries/data/models/business_model.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';

class GroceriesService {
  final Dio dio;

  GroceriesService(this.dio);

  Future<List<BusinessModel>> fetchGroceriesModels(
    String wilaya,
    double lat,
    double lng,
  ) async {
    try {
      final url = await ApiConfig.getBaseUrl();

      print("[DEBUG] $url");

      print("[DEBUG] waiting for response");
      final response = await dio.get(
        "http://192.168.43.83:3000/api/groceries/?wilaya=béjaïa",
      );
      print("[DEBUG] response received");

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> data = response.data;
        print("[DEBUG] $data");

        return data.map((e) => BusinessModel.fromJson(e)).toList();
      } else {
        throw Exception(
          'Failed to load groceries: status ${response.statusCode}',
        );
      }
    } on DioException catch (dioError) {
      print("[DIO ERROR] ${dioError.message}");
      print("[DIO ERROR] ${dioError.response}");
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
