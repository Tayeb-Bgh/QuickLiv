import 'package:mobileapp/features/customer/coupons_store/business/entities/coupon_entitie.dart';

abstract class CouponRepository {
  Future<void> createCoupon(CouponEntity coupon);
  Future<List<CouponEntity>> getClientCoupons();
}