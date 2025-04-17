import 'package:mobileapp/features/auth/business/entities/verify_otp_result.dart';
import 'package:mobileapp/features/auth/business/repositories/auth_repository_abstr.dart';
import 'package:mobileapp/features/auth/data/models/verify_otp_result_model.dart';
import 'package:mobileapp/features/auth/data/service/auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService service;

  AuthRepositoryImpl(this.service);

  @override
  Future<bool> checkPhoneNumber(String phoneNumber) async {
    return await service.checkPhoneNumber(phoneNumber);
  }

  @override
  Future<VerifyOtpResult> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    final VerifyOtpResultModel verifyResult = await service.verifyOtp(phoneNumber: phoneNumber, otp: otp);

    return VerifyOtpResult(success: verifyResult.success, role: verifyResult.role, token: verifyResult.token);
  }
}
