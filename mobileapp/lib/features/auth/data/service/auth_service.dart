import 'package:dio/dio.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/auth/data/models/verify_otp_result_model.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio);

  Future<bool> checkPhoneNumber(String phoneNumber) async {
    final url = await ApiConfig.getBaseUrl();

    final response = await dio.post(
      '$url/auth/login',
      data: {'phoneNumber': phoneNumber},
    );
    print("-+-+-+-+-+-+-+-+-++--+ ${response.data}");
    return response.data['success'] == true;
  }

  Future<VerifyOtpResultModel> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    final url = await ApiConfig.getBaseUrl();

    try {
      final response = await dio.post(
        "$url/auth/verify-otp",
        data: {'phoneNumber': phoneNumber, 'otp': otp},
      );
      return VerifyOtpResultModel(
        success: response.data["success"],
        role: response.data["role"],
        token: response.data["token"],
      );
    } catch (e) {
      // tu peux aussi logger ici si besoin
      return VerifyOtpResultModel(success: false, role: "null", token: "null");
    }
  }
}
