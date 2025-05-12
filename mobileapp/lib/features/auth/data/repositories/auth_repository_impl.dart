import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/auth/business/entities/customer_entity.dart';
import 'package:mobileapp/features/auth/business/entities/custumere_entity.dart';
import 'package:mobileapp/features/auth/business/entities/verify_otp_result.dart';
import 'package:mobileapp/features/auth/business/repositories/auth_repository_abstr.dart';
import 'package:mobileapp/features/auth/business/usecases/register_custumor_usecase.dart';
import 'package:mobileapp/features/auth/data/models/customer_model.dart';
import 'package:mobileapp/features/auth/data/models/verify_otp_result_model.dart';
import 'package:mobileapp/features/auth/data/service/auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService service;
  final Dio dio;
  final Ref ref;

  AuthRepositoryImpl(this.dio, this.ref) : service = AuthService(dio, ref);

  @override
  Future<bool> checkPhoneNumber(String phoneNumber) async {
    return await service.checkPhoneNumber(phoneNumber);
  }

  @override
  Future<VerifyOtpResult> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    final VerifyOtpResultModel verifyResult = await service.verifyOtp(
      phoneNumber: phoneNumber,
      otp: otp,
    );
    return VerifyOtpResult(
      success: verifyResult.success,
      role: verifyResult.role,
      token: verifyResult.token,
    );
  }

  @override
  Future<Customer> getCustomerInfo({required String phoneNumber}) async {
    final CustomerModel customerModel = await service.getCustomerInfo(
      phoneNumber: phoneNumber,
    );
    return customerModel.toEntity();
  }

  @override

  Future<void> registerUser(Customere user) async {
    await service.registerCustomer(user);
  }

  
}