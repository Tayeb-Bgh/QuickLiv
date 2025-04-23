import 'package:mobileapp/features/auth/business/entities/customer_entity.dart';
import 'package:mobileapp/features/auth/business/entities/deliverer_entity.dart';
import 'package:mobileapp/features/auth/business/entities/verify_otp_result.dart';
import 'package:mobileapp/features/auth/business/repositories/auth_repository_abstr.dart';
import 'package:mobileapp/features/auth/data/models/customer_model.dart';
import 'package:mobileapp/features/auth/data/models/deliverer_model.dart';
import 'package:mobileapp/features/auth/data/models/vehicle_model.dart';
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
  Future<Deliverer> getDelivererInfo({required String phoneNumber}) async {
    final DelivererModel delivererModel = await service.getDelivererInfo(
      phoneNumber: phoneNumber,
    );
    final VehicleModel vehicleModel = await service.getVehicleInfo(
      idDel: delivererModel.idDel,
    );

    final double rating = await service.getRating(
      idDel: delivererModel.idDel,
    );
    final int deliveryNbr = await service.getDeliveryNbr(
      idDel: delivererModel.idDel,
    );

    return delivererModel.toEntity(
      vehicle: vehicleModel.toEntity(),
      rating: rating,
      deliveryNbr: deliveryNbr,
    );
  }
}
