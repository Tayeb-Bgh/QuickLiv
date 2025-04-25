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
      print('Error in when creating coupon: $e');
      throw Exception('Failed to create coupon: $e');
    }
  }

//   @override
//   Future<CouponEntity> purchaseCoupon(String couponId, int clientId) async {
//     try {
//       final updatedCoupon = await couponService.purchaseCoupon(couponId, clientId);
//       return updatedCoupon.toEntity();
//     } catch (e) {
//       print('Error in repository when purchasing coupon: $e');
//       throw Exception('Failed to purchase coupon: $e');
//     }
//   }



//   @override
//   Future<CouponEntity> useCoupon(String couponId) async {
//     try {
//       final usedCoupon = await couponService.useCoupon(couponId);
//       return usedCoupon.toEntity();
//     } catch (e) {
//       print('Error in repository when using coupon: $e');
//       throw Exception('Failed to use coupon: $e');
//     }
//   }

//   @override
//   Future<List<CouponEntity>> getAvailableCoupons() async {
//     try {
//       final coupons = await couponService.getAvailableCoupons();
//       return coupons.map((model) => model.toEntity()).toList();
//     } catch (e) {
//       print('Error in repository when fetching available coupons: $e');
//       throw Exception('Failed to fetch available coupons: $e');
//     }
//   }

//   @override
//   Future<List<CouponEntity>> getClientCoupons(int clientId) async {
//     try {
//       final coupons = await couponService.getClientCoupons(clientId);
//       return coupons.map((model) => model.toEntity()).toList();
//     } catch (e) {
//       print('Error in repository when fetching client coupons: $e');
//       throw Exception('Failed to fetch client coupons: $e');
//     }
//   }
// }
}