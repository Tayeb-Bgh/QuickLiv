import 'package:dio/dio.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/customer/coupons_store/Data/models/coupon_model.dart';

class CouponService {
  final Dio dio;

  CouponService(this.dio);

  Future<void> setCoupon(CouponModel coupon) async {
    try {
      final url = await ApiConfig.getBaseUrl();
      print(dio.options.baseUrl);
      print("Sending POST to: ${dio.options.baseUrl}/createcoupon");

      await dio.post(
        '$url/create_coupon',
        data: {
          'reducRateCoupon': coupon.discountRate,
          'reducCodeCoupon': coupon.reductionCode,
          'isUsedCoup': coupon.isUsed,
        },
      );
    } catch (e) {
      print('Error when setting coupon: $e');
      throw Exception('Failed to set coupon: $e');
    }
  }
}















































































































































































































  // Future<CouponModel> purchaseCoupon(String couponId, int clientId) async {
  //   try {
  //     final url = await ApiConfig.getBaseUrl();
  //     // For production:
  //     // final response = await dio.put('$url/coupons/$couponId/purchase', data: {'client_id': clientId});
  //     // return CouponModel.fromJson(response.data);

  //     // Version with fake database
  //     final couponIndex = _fakeDatabase.indexWhere(
  //       (element) => element['id'] == couponId,
  //     );
  //     if (couponIndex == -1) {
  //       throw Exception('Coupon not found');
  //     }

  //     _fakeDatabase[couponIndex]['is_purchased'] = true;
  //     _fakeDatabase[couponIndex]['client_id'] = clientId;

  //     // Generate a random coupon code
  //     final couponCode = _generateRandomCouponCode();
  //     _fakeDatabase[couponIndex]['coupon_code'] = couponCode;

  //     return CouponModel.fromJson(_fakeDatabase[couponIndex]);
  //   } catch (e) {
  //     print('Error when purchasing coupon: $e');
  //     throw Exception('Failed to purchase coupon: $e');
  //   }
  // }






  // Future<CouponModel> useCoupon(String couponId) async {
  //   try {
  //     final url = await ApiConfig.getBaseUrl();
  //     // For production:
  //     // final response = await dio.put('$url/coupons/$couponId/use');
  //     // return CouponModel.fromJson(response.data);

  //     // Version with fake database
  //     final couponIndex = _fakeDatabase.indexWhere(
  //       (element) => element['id'] == couponId,
  //     );
  //     if (couponIndex == -1) {
  //       throw Exception('Coupon not found');
  //     }

  //     if (!_fakeDatabase[couponIndex]['is_purchased']) {
  //       throw Exception('Cannot use a coupon that hasn\'t been purchased');
  //     }

  //     _fakeDatabase[couponIndex]['is_used'] = true;

  //     return CouponModel.fromJson(_fakeDatabase[couponIndex]);
  //   } catch (e) {
  //     print('Error when using coupon: $e');
  //     throw Exception('Failed to use coupon: $e');
  //   }
  // }






  // Future<List<CouponModel>> getAvailableCoupons() async {
  //   try {
  //     final url = await ApiConfig.getBaseUrl();
  //     // For production:
  //     // final response = await dio.get('$url/coupons/available');
  //     // return (response.data as List).map((json) => CouponModel.fromJson(json)).toList();

  //     // Version with fake database
  //     final availableCoupons =
  //         _fakeDatabase
  //             .where((element) => element['is_purchased'] == false)
  //             .map((json) => CouponModel.fromJson(json))
  //             .toList();

  //     return availableCoupons;
  //   } catch (e) {
  //     print('Error when fetching available coupons: $e');
  //     throw Exception('Failed to fetch available coupons: $e');
  //   }
  // }






  // // Get client coupons
  // Future<List<CouponModel>> getClientCoupons(int clientId) async {
  //   try {
  //     final url = await ApiConfig.getBaseUrl();
  //     // For production:
  //     // final response = await dio.get('$url/coupons/client/$clientId');
  //     // return (response.data as List).map((json) => CouponModel.fromJson(json)).toList();

  //     // Version with fake database
  //     final clientCoupons =
  //         _fakeDatabase
  //             .where(
  //               (element) =>
  //                   element['client_id'] == clientId &&
  //                   element['is_purchased'] == true &&
  //                   element['is_used'] == false,
  //             )
  //             .map((json) => CouponModel.fromJson(json))
  //             .toList();

  //     return clientCoupons;
  //   } catch (e) {
  //     print('Error when fetching client coupons: $e');
  //     throw Exception('Failed to fetch client coupons: $e');
  //   }
  // }




