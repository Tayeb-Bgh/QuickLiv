import 'package:dio/dio.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio);

  Future<bool> checkPhoneNumber(String phoneNumber) async {
    final url = await ApiConfig.getBaseUrl();
    
    final response = await dio.post(
      '$url/auth/login',
      data: {'phoneNumber': phoneNumber},
    );

    return response.data['success'] == true;
  }
}
