import 'package:dio/dio.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/customer/coupons_store/Data/models/clientPoint_model.dart';

class CustomerPointService {
  final Dio dio;
  CustomerPointService(this.dio);

  Future<CustomerPointsModel> getCustomerPoints() async {
    try {
      final url = await ApiConfig.getBaseUrl();

      
      final response = await dio.get('$url/api/getClientPoint');

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
      
      final response = await dio.put(
        '$url/api/updateClientPoint',
        data: {'pointsCust': customerPoints},
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
