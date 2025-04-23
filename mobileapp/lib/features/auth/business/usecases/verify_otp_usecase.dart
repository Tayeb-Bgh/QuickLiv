import 'package:mobileapp/features/auth/business/entities/verify_otp_result.dart';
import 'package:mobileapp/features/auth/business/repositories/auth_repository_abstr.dart';

class VerifyOtpUseCase {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<VerifyOtpResult> call({required String phoneNumber, required String otp}) {
    
    return repository.verifyOtp(phoneNumber: phoneNumber, otp: otp);
  }
}
