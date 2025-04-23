// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mobileapp/features/customer/coupons_store/Data/repositories/Coupon_repositorie_impl.dart';
// import 'package:mobileapp/features/customer/coupons_store/Data/services/Coupon_service.dart';
// import 'package:mobileapp/features/customer/coupons_store/business/entities/coupon_entitie.dart';
// import 'package:mobileapp/features/customer/coupons_store/business/usercases/Coupon_user_case.dart';
// import 'package:mobileapp/features/example/presentation/providers/user_provider.dart';

// // Provider pour le repository
// final couponRepositoryProvider = Provider((ref) {
//   final dio = ref.watch(dioProvider);
//   final couponService = CouponService(dio);
//   return CouponRepositoryImpl(couponService);
// });

// // Provider pour le notifier principal
// final couponProvider = StateNotifierProvider<CouponNotifier, CouponState>((
//   ref,
// ) {
//   final couponRepository = ref.watch(couponRepositoryProvider);
//   return CouponNotifier(createCoupon: CreateCoupon(couponRepository));
// });

// // État minimal pour gérer uniquement la création de coupon
// enum CouponStatus { initial, loading, success, error }

// class CouponState {
//   final CouponStatus status;
//   final String? errorMessage;
//   final List<CouponEntity> coupons;

//   CouponState({
//     this.status = CouponStatus.initial,
//     this.errorMessage,
//     this.coupons = const [],
//   });
// }

// class CouponNotifier extends StateNotifier<CouponState> {
//   final CreateCoupon _createCoupon;

//   CouponNotifier({required CreateCoupon createCoupon})
//     : _createCoupon = createCoupon,
//       super(CouponState());

//   Future<void> createCoupon(String reducCode, int discountRate) async {
//     try {
//       state = CouponState(status: CouponStatus.loading, coupons: state.coupons);

//       final newCoupon = CouponEntity(
//         reductionCode: reducCode,
//         discountRate: discountRate,
//       );

//       await _createCoupon(newCoupon);

//       state = CouponState(
//         status: CouponStatus.success,
//         coupons: [...state.coupons, newCoupon],
//       );
//     } catch (e) {
//       state = CouponState(
//         status: CouponStatus.error,
//         errorMessage: 'Erreur lors de la création du coupon: $e',
//         coupons: state.coupons,
//       );
//     }
//   }

//   void removeCouponByDiscountRate(int discountRate) {
//     final updatedCoupons =
//         state.coupons
//             .where((coupon) => coupon.discountRate != discountRate)
//             .toList();

//     state = CouponState(status: state.status, coupons: updatedCoupons);
//   }

//   void resetStatus() {
//     state = CouponState(status: CouponStatus.initial, coupons: state.coupons);
//   }
// }

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mobileapp/features/customer/coupons_store/Data/repositories/Coupon_repositorie_impl.dart';
// import 'package:mobileapp/features/customer/coupons_store/Data/services/Coupon_service.dart';
// import 'package:mobileapp/features/customer/coupons_store/business/entities/coupon_entitie.dart';
// import 'package:mobileapp/features/customer/coupons_store/business/usercases/Coupon_user_case.dart';
// import 'package:mobileapp/features/example/presentation/providers/user_provider.dart';

// // Provider pour le repository
// final couponRepositoryProvider = Provider((ref) {
//   final dio = ref.watch(dioProvider);
//   final couponService = CouponService(dio);
//   return CouponRepositoryImpl(couponService);
// });

// // Provider pour le notifier principal
// final couponProvider = StateNotifierProvider<CouponNotifier, CouponState>((
//   ref,
// ) {
//   final couponRepository = ref.watch(couponRepositoryProvider);
//   final createCoupon = CreateCoupon(couponRepository);

//   return CouponNotifier(
//     createCoupon: createCoupon,
//   );
// });

// // État pour gérer les coupons
// enum CouponStatus { initial, loading, success, error }

// class CouponState {
//   final CouponStatus status;
//   final String? errorMessage;
//   final List<CouponEntity> coupons;
//   final bool isProcessing;

//   CouponState({
//     this.status = CouponStatus.initial,
//     this.errorMessage,
//     this.coupons = const [],
//     this.isProcessing = false,
//   });

//   CouponState copyWith({
//     CouponStatus? status,
//     String? errorMessage,
//     List<CouponEntity>? coupons,
//     bool? isProcessing,
//   }) {
//     return CouponState(
//       status: status ?? this.status,
//       errorMessage: errorMessage ?? this.errorMessage,
//       coupons: coupons ?? this.coupons,
//       isProcessing: isProcessing ?? this.isProcessing,
//     );
//   }
// }

// class CouponNotifier extends StateNotifier<CouponState> {
//   final CreateCoupon _createCoupon;

//   CouponNotifier({
//     required CreateCoupon createCoupon,
//   }) : _createCoupon = createCoupon,
//        super(CouponState());

//   Future<void> createCoupon(String reducCode, int discountRate) async {
//     if (state.isProcessing) {
//       return; // Éviter les doubles soumissions
//     }

//     try {
//       state = state.copyWith(
//         status: CouponStatus.loading,
//         isProcessing: true,
//         errorMessage: null,
//       );

//       // Vérifier si un coupon avec ce taux de réduction existe déjà
//       final couponExists = state.coupons.any(
//         (coupon) => coupon.discountRate == discountRate
//       );

//       if (couponExists) {
//         state = state.copyWith(
//           status: CouponStatus.error,
//           isProcessing: false,
//           errorMessage: 'Vous possédez déjà un coupon de $discountRate%',
//         );
//         return;
//       }

//       final newCoupon = CouponEntity(
//         reductionCode: reducCode,
//         discountRate: discountRate,
//       );

//       // Simuler un délai pour l'opération réseau
//       await Future.delayed(const Duration(milliseconds: 500));
//       await _createCoupon(newCoupon);

//       state = state.copyWith(
//         status: CouponStatus.success,
//         isProcessing: false,
//         coupons: [...state.coupons, newCoupon],
//       );
//     } catch (e) {
//       state = state.copyWith(
//         status: CouponStatus.error,
//         isProcessing: false,
//         errorMessage: 'Erreur lors de la création du coupon: $e',
//       );
//     }
//   }

//   void removeCouponByDiscountRate(int discountRate) {
//     final updatedCoupons =
//         state.coupons
//             .where((coupon) => coupon.discountRate != discountRate)
//             .toList();

//     state = state.copyWith(coupons: updatedCoupons);
//   }

//   void resetStatus() {
//     state = state.copyWith(
//       status: CouponStatus.initial,
//       errorMessage: null,
//     );
//   }

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/customer/coupons_store/Data/repositories/Coupon_repositorie_impl.dart';
import 'package:mobileapp/features/customer/coupons_store/Data/services/Coupon_service.dart';
import 'package:mobileapp/features/customer/coupons_store/Data/services/hive_service.dart';
import 'package:mobileapp/features/customer/coupons_store/business/entities/coupon_entitie.dart';
import 'package:mobileapp/features/customer/coupons_store/business/usercases/Coupon_user_case.dart';
import 'package:mobileapp/features/example/presentation/providers/user_provider.dart';

// Provider pour le repository
final couponRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final couponService = CouponService(dio);
  return CouponRepositoryImpl(couponService);
});

// Provider pour le notifier principal
final couponProvider = StateNotifierProvider<CouponNotifier, CouponState>((
  ref,
) {
  final couponRepository = ref.watch(couponRepositoryProvider);
  return CouponNotifier(createCoupon: CreateCoupon(couponRepository));
});

// État minimal pour gérer uniquement la création de coupon
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

  CouponNotifier({required CreateCoupon createCoupon})
    : _createCoupon = createCoupon,
      super(CouponState()) {
    _loadCouponsFromStorage();
  }
  Future<void> fetchCoupons() async {
    await _loadCouponsFromStorage();
  }

  // Charger les coupons depuis Hive au démarrage
  Future<void> _loadCouponsFromStorage() async {
    final savedCoupons = HiveStorageService.getCoupons();
    if (savedCoupons.isNotEmpty) {
      state = CouponState(status: CouponStatus.success, coupons: savedCoupons);
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

      // Sauvegarder dans Hive
      await HiveStorageService.saveCoupons(updatedCoupons);

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

    // Mettre à jour Hive
    await HiveStorageService.saveCoupons(updatedCoupons);

    state = CouponState(status: state.status, coupons: updatedCoupons);
  }

  void resetStatus() {
    state = CouponState(status: CouponStatus.initial, coupons: state.coupons);
  }

  // Méthode pour forcer un rechargement des coupons depuis le stockage local
  void reloadCouponsFromStorage() {
    _loadCouponsFromStorage();
  }
}
