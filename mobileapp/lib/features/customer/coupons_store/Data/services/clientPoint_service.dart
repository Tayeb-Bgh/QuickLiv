import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/customer/coupons_store/Data/models/clientPoint_model.dart';
import 'package:mobileapp/features/auth/presentation/providers/auth_provider.dart';

class CustomerPointService {
  final Dio dio;
  final Ref ref; // Add Riverpod ref for accessing token

  CustomerPointService(this.dio, this.ref);
  Future<CustomerPointsModel> getCustomerPoints() async {
    try {
      final url = await ApiConfig.getBaseUrl();
      final token = await ref.read(jwtTokenProvider.future);
      // Get token from your provider

      final response = await dio.get(
        '$url/coupon/get-client-point',
        options: Options(headers: {'authorization': 'Bearer $token'}),
      );

      if (response.data['success'] == true) {
        return CustomerPointsModel.fromJson(response.data['data']);
      } else {
        throw Exception(
          response.data['message'] ?? 'Failed to get client points',
        );
      }
    } catch (e) {
      print('Error when fetching client points: $e');
      throw Exception('Failed to fetch client points: $e');
    }
  }

  Future<void> updateCustomerPoints(int customerPoints) async {
    try {
      final url = await ApiConfig.getBaseUrl();
      final token = await ref.read(
        jwtTokenProvider.future,
      ); // Get token from your provider

      final response = await dio.put(
        '$url/coupon/update-client-point',
        data: {'pointsCust': customerPoints},
        options: Options(headers: {'authorization': 'Bearer $token'}),
      );

      if (response.data['success'] != true) {
        throw Exception(
          response.data['message'] ?? 'Failed to update client points',
        );
      }
    } catch (e) {
      print('Error when updating client points: $e');
      throw Exception('Failed to update client points: $e');
    }
  }
}
