import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/auth/business/entities/customer_entity.dart';
import 'package:mobileapp/features/auth/business/entities/custumere_entity.dart';
import 'package:mobileapp/features/auth/data/models/customer_model.dart';
import 'package:mobileapp/features/auth/data/models/verify_otp_result_model.dart';
import 'package:mobileapp/features/auth/presentation/providers/auth_provider.dart';

class AuthService {
  final Dio dio;
  final Ref ref;

  AuthService(this.dio, this.ref);

  Future<bool> checkPhoneNumber(String phoneNumber) async {
    final url = await ApiConfig.getBaseUrl();

    final response = await dio.post(
      '$url/auth/login',
      data: {'phoneNumber': phoneNumber},
      options: Options(
        sendTimeout: Duration(seconds: 8),
        receiveTimeout: Duration(seconds: 8),
      ),
    );

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
      print("Error during OTP verification: $e");
      return VerifyOtpResultModel(success: false, role: "null", token: "null");
    }
  }

  Future<CustomerModel> getCustomerInfo({required String phoneNumber}) async {
    final url = await ApiConfig.getBaseUrl();
    final token = await ref.read(jwtTokenProvider.future);

    try {
      final response = await dio.get(
        "$url/auth/customers/by-phone",
        data: {'phoneNumber': phoneNumber},
        options: Options(
          sendTimeout: Duration(seconds: 8),
          receiveTimeout: Duration(seconds: 8),
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $token',
          },
        ),
      );

      final responseData = Map<String, dynamic>.from(response.data);
      responseData['phoneCust'] = phoneNumber;

      final customerModel = CustomerModel.fromJson(responseData);

      return customerModel;
    } catch (e) {
      print("❌ Erreur dans getCustomerInfo: $e");
      return CustomerModel(
        idCust: 0,
        pointsCust: 0,
        firstNameCust: "",
        lastNameCust: "",
        birthDateCust: "",
        phoneCust: phoneNumber,
        registerDateCust: DateTime.now(),
        isSubmittedDelivererCust: false,
        isSubmittedPartnerCust: false,
      );
    }
  }

  Future<void> registerCustomer(Customere customer) async {
    final url = await ApiConfig.getBaseUrl();
    final token = await ref.read(jwtTokenProvider.future);

    try {
      final response = await dio.post(
        // Changé de PUT à POST
        "$url/auth/register",
        data: customer.toJson(),
        options: Options(
          sendTimeout: Duration(seconds: 8),
          receiveTimeout: Duration(seconds: 8)
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Erreur lors de l\'inscription du client.');
      }
    } catch (e) {
      print("❌ Erreur dans registerCustomer: $e");
      throw Exception('Erreur lors de l\'inscription du client.');
    }
  }
}
