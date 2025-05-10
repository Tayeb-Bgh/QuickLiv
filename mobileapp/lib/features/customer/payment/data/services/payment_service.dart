import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/auth/presentation/providers/auth_provider.dart';
import 'package:mobileapp/features/customer/payment/Data/models/coupon_model.dart';

class PaymentService {
  final Dio dio;
  final Ref ref;
  PaymentService({required this.dio, required this.ref});

  Future<List<CouponModel>> fetchUserCoupons() async {
    final baseUrl = await ApiConfig.getBaseUrl();
    final url = "$baseUrl/payment/coupons";
    try {
      final secureStorage = ref.watch(secureStorageProvider);

      String? token = await secureStorage.read(key: "authToken");

      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        return data.map((el) => CouponModel.fromJson(el)).toList();
      } else {
        throw Error();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<int> insertCart(Map<String, dynamic> cartData) async {
    final baseUrl = await ApiConfig.getBaseUrl();
    final url = "$baseUrl/payment/carts";
    try {
      final secureStorage = ref.watch(secureStorageProvider);

      String? token = await secureStorage.read(key: "authToken");

      final response = await dio.post(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $token',
          },
        ),
        data: cartData,
      );

      if (response.statusCode == 201) {
        return response.data["id"];
      } else {
        throw Error();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> insertProductCart(Map<String, dynamic> productCartData) async {
    final baseUrl = await ApiConfig.getBaseUrl();
    final url = "$baseUrl/payment/carts/product-cart";
    try {
      final secureStorage = ref.watch(secureStorageProvider);

      String? token = await secureStorage.read(key: "authToken");

      final response = await dio.post(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $token',
          },
        ),
        data: productCartData,
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        throw Error();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> insertOrder(Map<String, dynamic> orderData) async {
    final baseUrl = await ApiConfig.getBaseUrl();
    final url = "$baseUrl/payment/orders";
    try {
      final secureStorage = ref.watch(secureStorageProvider);

      String? token = await secureStorage.read(key: "authToken");

      final response = await dio.post(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $token',
          },
        ),
        data: orderData,
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        throw Error();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateCouponStatus(int id) async {
    final baseUrl = await ApiConfig.getBaseUrl();
    final url = "$baseUrl/payment/coupons/$id";
    try {
      final secureStorage = ref.watch(secureStorageProvider);

      String? token = await secureStorage.read(key: "authToken");

      final response = await dio.put(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        throw Error();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getMistralResponse(Map<String, dynamic> json) async {
    final String baseUrl = await ApiConfig.getBaseUrl();
    final String url = "$baseUrl/ai/delivery-type";

    try {
      final response = await dio.post(
        url,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: json,
      );

      if (response.statusCode == 200) {
        print("[DEBUG] mistral !!!!  $response");
        return response.data["deliveryMethod"] as String;
      } else {
        throw Error();
      }
    } catch (e) {
      rethrow;
    }
  }
}
