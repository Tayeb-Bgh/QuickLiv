import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mobileapp/features/customer/cart_popup/business/entities/cart_entity.dart';
import 'package:mobileapp/features/customer/payment/Data/models/coupon_model.dart';
import 'package:mobileapp/features/customer/payment/business/usecases/insert_order.dart';
import 'package:mobileapp/features/customer/payment/business/usecases/verif_coupon.dart';
import 'package:mobileapp/features/customer/payment/data/repositories/payment_repository_impl.dart';
import 'package:mobileapp/features/customer/payment/data/services/payment_service.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final paymentServiceProvider = Provider<PaymentService>((ref) {
  return PaymentService(dio: ref.watch(dioProvider), ref: ref);
});

final paymentRepositoryProvider = Provider<PaymentRepositoryImpl>((ref) {
  return PaymentRepositoryImpl(
    paymentService: ref.watch(paymentServiceProvider),
  );
});

class CouponsNotifier extends StateNotifier<AsyncValue<List<CouponModel>>> {
  final PaymentService service;

  CouponsNotifier(this.service) : super(const AsyncValue.data([]));

  Future<void> fetchCoupons() async {
    state = const AsyncValue.loading();
    try {
      final coupons = await service.fetchUserCoupons();
      state = AsyncValue.data(coupons);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final couponsNotifierProvider =
    StateNotifierProvider<CouponsNotifier, AsyncValue<List<CouponModel>>>(
      (ref) => CouponsNotifier(ref.watch(paymentServiceProvider)),
    );

final verifCouponProvider = Provider<VerifCoupon>((ref) {
  return VerifCoupon();
});

final couponTextProvider = StateProvider<String>((ref) => "");

final couponControllerProvider = Provider.autoDispose<TextEditingController>((
  ref,
) {
  final initialText = ref.read(couponTextProvider); // read instead of watch
  final controller = TextEditingController(text: initialText);

  ref.onDispose(() => controller.dispose());

  return controller;
});

final usedCouponProvider = StateProvider<CouponModel?>((ref) {
  return null;
});

final actualCartProvider = StateProvider<Cart?>((ref) {
  return null;
});

final billInformationsProvider = Provider<Map<String, dynamic>>((ref) {
  Cart? cart = ref.watch(actualCartProvider);

  if (cart == null) return {};
  CouponModel? coupon = ref.watch(usedCouponProvider);

  final int id = cart.idBusns;
  final double totalProducts = cart.prodPrice;
  final double totalDeliv = cart.delivPrice;
  final double totalReduc =
      coupon == null ? 0 : (totalDeliv * coupon.reducRateCoupon) / 100;
  final double delivPriceWreduc = totalDeliv - totalReduc;
  final total = delivPriceWreduc + totalProducts;

  return {
    "id": id,
    "totalProducts": totalProducts,
    "totalDeliv": totalDeliv,
    "totalReduc": totalReduc,
    "total": total,
  };
});

final insertOrderProvider = Provider<InsertOrder>((ref) {
  return InsertOrder(paymentRepository: ref.watch(paymentRepositoryProvider));
});

class InsertOrderParams {
  final Cart cart;
  final CouponModel? coupon;
  final double custLat;
  final double custLng;
  final double deliveryPrice;
  final int? transNbr;

  InsertOrderParams({
    required this.cart,
    required this.coupon,
    required this.custLat,
    required this.custLng,
    required this.deliveryPrice,
    this.transNbr,
  });
}

final insertOrderFamilyProvider =
    FutureProvider.family<void, InsertOrderParams>((ref, params) async {
      final insertOrder = ref.watch(insertOrderProvider);
      await insertOrder.call(
        params.cart,
        params.coupon,
        params.custLat,
        params.custLng,
        params.deliveryPrice,
        params.transNbr,
      );
    });
