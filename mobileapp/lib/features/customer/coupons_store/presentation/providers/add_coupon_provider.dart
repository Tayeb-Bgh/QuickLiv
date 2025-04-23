
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Classe Coupon
class Coupon {
  final int points;
  final String assetPath;

  Coupon({required this.points, required this.assetPath});
}

class CouponNotifier extends StateNotifier<List<Coupon>> {
  CouponNotifier() : super([]);

  void addCoupon({required int points, required String assetPath}) {
    final coupon = Coupon(points: points, assetPath: assetPath);
    state = [...state, coupon]; // ajoute le coupon à la liste
  }
}

final addCouponProvider = StateNotifierProvider<CouponNotifier, List<Coupon>>(
  (ref) => CouponNotifier(),
);