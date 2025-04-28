import 'package:mobileapp/features/customer/coupons_store/business/entities/coupon_entitie.dart';
import 'package:mobileapp/features/customer/coupons_store/business/repositories/coupon_repositorie.dart';

class CreateCoupon {
  final CouponRepository repository;

  CreateCoupon(this.repository);

  Future<void> call(CouponEntity coupon) async {
    await repository.createCoupon(coupon);
  }
}
class GetClientCoupons {
  final CouponRepository repository;

  GetClientCoupons(this.repository);

  Future<List<CouponEntity>> call() async {
    return await repository.getClientCoupons();
  }
}
