import 'package:mobileapp/features/customer/payment/Data/models/coupon_model.dart';

class VerifCoupon {
  CouponModel? call(List<CouponModel> couponsList, String couponS) {
    final CouponModel? coupon =
        couponsList
            .where((coupon) => coupon.reducCodeCoupon == couponS)
            .firstOrNull;

    return coupon;
  }
}
