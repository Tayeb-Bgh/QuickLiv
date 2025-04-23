import 'package:mobileapp/features/customer/coupons_store/business/entities/coupon_entitie.dart';

abstract class CouponRepository {
  // Création d'un coupon dans la base de données
  Future<void> createCoupon(CouponEntity coupon);
  
  // // Achat d'un coupon par un client
  // Future<CouponEntity> purchaseCoupon(String couponId, int clientId);
  
  // // Utilisation d'un coupon
  // Future<CouponEntity> useCoupon(String couponId);
  
  // // Récupérer tous les coupons disponibles à l'achat
  // Future<List<CouponEntity>> getAvailableCoupons();
  
  // // Récupérer les coupons d'un client (achetés mais non utilisés)
  // Future<List<CouponEntity>> getClientCoupons(int clientId);
}