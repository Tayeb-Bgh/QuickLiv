import 'package:dio/dio.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/auth/data/models/customer_model.dart';
import 'package:mobileapp/features/auth/data/models/deliverer_model.dart';
import 'package:mobileapp/features/auth/data/models/vehicle_model.dart';
import 'package:mobileapp/features/auth/data/models/verify_otp_result_model.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio);

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

    try {
      final response = await dio.get(
        "$url/auth/customers/by-phone",
        data: {'phoneNumber': phoneNumber},
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
        phoneCust: phoneNumber,
        registerDateCust: DateTime.now(),
        isSubmittedDelivererCust: false,
        isSubmittedPartnerCust: false,
      );
    }
  }

  Future<DelivererModel> getDelivererInfo({required String phoneNumber}) async {
    final url = await ApiConfig.getBaseUrl();

    try {
      final response = await dio.get(
        "$url/auth/deliverers/by-phone",
        data: {'phoneNumber': phoneNumber},
      );

      final responseData = Map<String, dynamic>.from(response.data);
      responseData['phoneDel'] = phoneNumber;

      final delivererModel = DelivererModel.fromJson(responseData);

      return delivererModel;
    } catch (e) {
      print("❌ Erreur dans getDelivererInfo: $e");
      return DelivererModel(
        idDel: 0,
        firstNameDel: "",
        lastNameDel: "",
        phoneDel: phoneNumber,
        registerDateDel: DateTime.now(),
        emailDel: "",
        adrsDel: "",
        statusDel: false,
      );
    }
  }

  Future<VehicleModel> getVehicleInfo({required int idDel}) async {
    final url = await ApiConfig.getBaseUrl();

    try {
      final response = await dio.get(
        "$url/auth/deliverer/vehicle/by-deliverer-id",
        data: {'idDel': idDel},
      );
      return VehicleModel.fromJson(response.data);
    } catch (e) {
      print("❌ Erreur dans getVehicleInfo: $e");
      return VehicleModel(
        idVehc: 0,
        typeVehc: VehicleType.scooter,
        brandVehc: "",
        modelVehc: "",
        colorVehc: "",
        registerNbrVehc: "",
        yearVehc: DateTime.now(),
        insuranceExprVehc: DateTime.now(),
      );
    }
  }

  Future<double> getRating({required int idDel}) async {
    final url = await ApiConfig.getBaseUrl();

    try {
      final response = await dio.get(
        "$url/auth/deliverer/rating",
        data: {'idDel': idDel},
      );

      final rating = response.data["rating"];
      return rating is double
          ? rating
          : double.tryParse(rating.toString()) ?? 5;
    } catch (e) {
      print("❌ Erreur dans getRating: $e");
      return 0;
    }
  }

  Future<int> getDeliveryNbr({required int idDel}) async {
    final url = await ApiConfig.getBaseUrl();

    try {
      final response = await dio.get(
        "$url/auth/deliverer/delivery-number",
        data: {'idDel': idDel},
      );
      final deliveryNbr = response.data["deliveryNbr"];
      return deliveryNbr is int
          ? deliveryNbr
          : int.tryParse(deliveryNbr.toString()) ?? 5;
    } catch (e) {
      print("❌ Erreur dans getDeliveryNbr: $e");
      return 0;
    }
  }
}
