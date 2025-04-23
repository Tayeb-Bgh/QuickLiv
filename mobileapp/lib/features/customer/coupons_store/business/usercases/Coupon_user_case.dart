import 'package:mobileapp/features/customer/coupons_store/business/entities/coupon_entitie.dart';
import 'package:mobileapp/features/customer/coupons_store/business/repositories/coupon_repositorie.dart';

// Cas d'utilisation pour créer un coupon
class CreateCoupon {
  final CouponRepository repository;

  CreateCoupon(this.repository);

  Future<void> call(CouponEntity coupon) async {
    await repository.createCoupon(coupon);
  }
}

// // Cas d'utilisation pour acheter un coupon
// class PurchaseCoupon {
//   final CouponRepository repository;

//   PurchaseCoupon(this.repository);

//   Future<CouponEntity> call(String couponId, int clientId) async {
//     return await repository.purchaseCoupon(couponId, clientId);
//   }
// }

// // Cas d'utilisation pour utiliser un coupon
// class UseCoupon {
//   final CouponRepository repository;

//   UseCoupon(this.repository);

//   Future<CouponEntity> call(String couponId) async {
//     return await repository.useCoupon(couponId);
//   }
// }

// // Cas d'utilisation pour récupérer les coupons disponibles
// class GetAvailableCoupons {
//   final CouponRepository repository;

//   GetAvailableCoupons(this.repository);

//   Future<List<CouponEntity>> call() async {
//     return await repository.getAvailableCoupons();
//   }
// }

// // Cas d'utilisation pour récupérer les coupons d'un client
// class GetClientCoupons {
//   final CouponRepository repository;

//   GetClientCoupons(this.repository);

//   Future<List<CouponEntity>> call(int clientId) async {
//     return await repository.getClientCoupons(clientId);
//   }
// }
