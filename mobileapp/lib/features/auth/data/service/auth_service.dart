import 'package:dio/dio.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/auth/data/models/verify_otp_model.dart';

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

  Future<VerifyOtpModel> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    final url = await ApiConfig.getBaseUrl();
    
    try {
      final response = await dio.post(
        "${url}/auth/verify-otp",
        data: {'phoneNumber': phoneNumber, 'otp': otp},
      );
      return VerifyOtpModel(success: response.data["success"], role: response.data["role"]);
    } catch (e) {
      // tu peux aussi logger ici si besoin
      return VerifyOtpModel(success: false, role: "null");
    }
  }
}
