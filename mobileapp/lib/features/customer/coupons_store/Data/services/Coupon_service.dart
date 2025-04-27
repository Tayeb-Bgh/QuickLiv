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
      print('Error when setting coupon: $e');
      throw Exception('Failed to set coupon: $e');
    }
  }
}
