import 'package:mobileapp/features/customer/coupons_store/business/entities/coupon_entitie.dart';
import 'package:mobileapp/features/customer/coupons_store/business/repositories/coupon_repositorie.dart';
import 'package:mobileapp/features/customer/coupons_store/Data/models/coupon_model.dart';
import 'package:mobileapp/features/customer/coupons_store/Data/services/Coupon_service.dart';

class CouponRepositoryImpl implements CouponRepository {
  final CouponService couponService;

  CouponRepositoryImpl(this.couponService);

  @override
  Future<void> createCoupon(CouponEntity coupon) async {
    try {
      final couponModel = CouponModel.fromEntity(coupon);
      await couponService.setCoupon(couponModel);
    } catch (e) {
      throw Exception('Failed to create coupon: $e');
    }
  }

  @override
  Future<List<CouponEntity>> getClientCoupons() async {
    try {
      final coupons = await couponService.getUnusedCoupons();
      return coupons.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to fetch client coupons: $e');
    }
  }
}
