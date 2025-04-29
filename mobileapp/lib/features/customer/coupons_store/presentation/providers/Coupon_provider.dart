import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/customer/coupons_store/Data/repositories/Coupon_repositorie_impl.dart';
import 'package:mobileapp/features/customer/coupons_store/Data/services/Coupon_service.dart';
import 'package:mobileapp/features/customer/coupons_store/business/entities/coupon_entitie.dart';
import 'package:mobileapp/features/customer/coupons_store/business/usercases/Coupon_user_case.dart';
import 'package:mobileapp/features/example/presentation/providers/user_provider.dart';

final couponRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final couponService = CouponService(dio, ref);
  return CouponRepositoryImpl(couponService);
});

final couponProvider = StateNotifierProvider<CouponNotifier, CouponState>((
  ref,
) {
  final couponRepository = ref.watch(couponRepositoryProvider);
  return CouponNotifier(
    createCoupon: CreateCoupon(couponRepository),
    getClientCoupons: GetClientCoupons(couponRepository),
  );
});

enum CouponStatus { initial, loading, success, error }

class CouponState {
  final CouponStatus status;
  final String? errorMessage;
  final List<CouponEntity> coupons;

  CouponState({
    this.status = CouponStatus.initial,
    this.errorMessage,
    this.coupons = const [],
  });
}

class CouponNotifier extends StateNotifier<CouponState> {
  final CreateCoupon _createCoupon;
  final GetClientCoupons _getClientCoupons;

  CouponNotifier({
    required CreateCoupon createCoupon,
    required GetClientCoupons getClientCoupons,
  }) : _createCoupon = createCoupon,
       _getClientCoupons = getClientCoupons,
       super(CouponState()) {
  }

  Future<void> fetchCoupons() async {
    try {
      state = CouponState(status: CouponStatus.loading, coupons: state.coupons);

      final coupons = await _getClientCoupons();

      state = CouponState(status: CouponStatus.success, coupons: coupons);

    } catch (e) {
      state = CouponState(
        status: CouponStatus.error,
        errorMessage: 'Erreur lors de la récupération des coupons: $e',
        coupons: state.coupons,
      );
    }
  }



  Future<void> createCoupon(String reducCode, int discountRate) async {
    try {
      state = CouponState(status: CouponStatus.loading, coupons: state.coupons);

      final newCoupon = CouponEntity(
        reductionCode: reducCode,
        discountRate: discountRate,
      );

      await _createCoupon(newCoupon);

      final updatedCoupons = [...state.coupons, newCoupon];

      state = CouponState(
        status: CouponStatus.success,
        coupons: updatedCoupons,
      );
    } catch (e) {
      state = CouponState(
        status: CouponStatus.error,
        errorMessage: 'Erreur lors de la création du coupon: $e',
        coupons: state.coupons,
      );
    }
  }

  void removeCouponByDiscountRate(int discountRate) async {
    final updatedCoupons =
        state.coupons
            .where((coupon) => coupon.discountRate != discountRate)
            .toList();

    state = CouponState(status: state.status, coupons: updatedCoupons);
  }

  void resetStatus() {
    state = CouponState(status: CouponStatus.initial, coupons: state.coupons);
  }

 
}

final isActiveCoupon30 = StateProvider<bool>((ref) {
  return false;
});

final isActiveCoupon60 = StateProvider<bool>((ref) {
  return false;
});

final isActiveCoupon100 = StateProvider<bool>((ref) {
  return false;
});

final loadingCoupon30Provider = StateProvider<bool>((ref) => false);
final loadingCoupon60Provider = StateProvider<bool>((ref) => false);
final loadingCoupon100Provider = StateProvider<bool>((ref) => false);
