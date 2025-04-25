import 'package:mobileapp/features/customer/coupons_store/business/entities/coupon_entitie.dart';

class CouponModel {
  final int discountRate;
  final String? reductionCode;
  final bool? isUsed;

  CouponModel({required this.discountRate, this.reductionCode, this.isUsed});

  factory CouponModel.fromEntity(CouponEntity entity) {
    return CouponModel(
      discountRate: entity.discountRate,
      reductionCode: entity.reductionCode,
      isUsed: true,
    );
  }

  CouponEntity toEntity() {
    return CouponEntity(
      discountRate: discountRate,
      reductionCode: reductionCode,
    );
  }

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      discountRate: json['reducRateCoupon'],
      isUsed: json['isUsedCoup'],
      reductionCode: json['reducCodeCoupon'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'reducRateCoupon': discountRate,
      'isUsedCoup': isUsed,
      'reducCodeCoupon': reductionCode,
    };
  }
}
