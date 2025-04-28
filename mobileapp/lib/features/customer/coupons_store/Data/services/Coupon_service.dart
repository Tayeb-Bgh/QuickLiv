import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/customer/coupons_store/Data/models/coupon_model.dart';
import 'package:mobileapp/features/auth/presentation/providers/auth_provider.dart';

class CouponService {
  final Dio dio;
  final Ref ref;

  CouponService(this.dio, this.ref);

  Future<void> setCoupon(CouponModel coupon) async {
    try {
      final url = await ApiConfig.getBaseUrl();
      final token = await ref.read(jwtTokenProvider.future);

      await dio.post(
        '$url/coupon/create-coupon',
        data: {
          'reducRateCoupon': coupon.discountRate,
          'reducCodeCoupon': coupon.reductionCode,
          'isUsedCoup': coupon.isUsed,
        },
        options: Options(headers: {'authorization': 'Bearer $token'}),
      );
    } catch (e) {
      throw Exception('Failed to set coupon: $e');
    }
  }

  Future<List<CouponModel>> getUnusedCoupons() async {
    try {
      final url = await ApiConfig.getBaseUrl();
      final token = await ref.read(jwtTokenProvider.future);

      final response = await dio.get(
        '$url/coupon/get-unused-coupon',
        options: Options(headers: {'authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 && response.data['success']) {
        final couponsData = response.data['coupon'] as List;

        return couponsData
            .map((couponJson) => CouponModel.fromJson(couponJson))
            .toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
