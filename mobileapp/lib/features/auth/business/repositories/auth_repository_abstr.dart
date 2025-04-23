import 'package:mobileapp/features/auth/business/entities/customer_entity.dart';
import 'package:mobileapp/features/auth/business/entities/deliverer_entity.dart';
import 'package:mobileapp/features/auth/business/entities/verify_otp_result.dart';

abstract class AuthRepository {
  Future<bool> checkPhoneNumber(String phoneNumber);
  Future<VerifyOtpResult> verifyOtp({required String phoneNumber,required String otp});
  Future<Customer> getCustomerInfo({required String phoneNumber});
  Future<Deliverer> getDelivererInfo({required String phoneNumber});
}
