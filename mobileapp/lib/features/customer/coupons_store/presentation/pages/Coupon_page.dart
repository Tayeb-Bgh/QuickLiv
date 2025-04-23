// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:mobileapp/features/customer/coupons_store/presentation/widgets/AvailableCoupon.dart';
// import 'package:mobileapp/features/customer/coupons_store/presentation/widgets/MyCoupon.dart';
// import 'package:mobileapp/features/customer/coupons_store/presentation/widgets/MyPoints.dart';

// class CouponPage extends StatelessWidget {
//   const CouponPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Column(
//             children: [
//               SizedBox(height: 40),
//               MyPoints(),
//               SizedBox(height: 10),
//               MyCoupon(),
//               SizedBox(height: 10),
//               Availablecoupon(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:mobileapp/features/customer/coupons_store/presentation/widgets/AvailableCoupon.dart';
// import 'package:mobileapp/features/customer/coupons_store/presentation/widgets/MyCoupon.dart';
// import 'package:mobileapp/features/customer/coupons_store/presentation/widgets/MyPoints.dart';

// class CouponPage extends StatelessWidget {
//   const CouponPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Column(
//             children: [
//               SizedBox(height: 40),
//               MyPoints(),
//               SizedBox(height: 10),
//               MyCoupon(),
//               SizedBox(height: 10),
//               Availablecoupon(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/failure/failure.dart';
import 'package:mobileapp/features/customer/coupons_store/presentation/providers/Coupon_provider.dart';
import 'package:mobileapp/features/customer/coupons_store/presentation/widgets/AvailableCoupon.dart';
import 'package:mobileapp/features/customer/coupons_store/presentation/widgets/MyCoupon.dart';
import 'package:mobileapp/features/customer/coupons_store/presentation/widgets/MyPoints.dart';

class CouponPage extends ConsumerStatefulWidget {
  const CouponPage({super.key});

  @override
  ConsumerState<CouponPage> createState() => _CouponPageState();
}

class _CouponPageState extends ConsumerState<CouponPage> {
  Future<void> _refresh() async {
    // Rafraîchir à la fois les données des points et des coupons
    
    await ref.refresh(couponProvider.notifier).fetchCoupons();
  }

  @override
  Widget build(BuildContext context) {
    // Surveiller les états des deux fournisseurs principaux
    
    final couponsState = ref.watch(couponProvider);

    // Combiner les états pour déterminer l'état global
    // Si l'un des deux est en chargement, on affiche le chargement
    // Si l'un des deux est en erreur, on affiche l'erreur
    // Sinon, on affiche le contenu
    return Scaffold(
      body: () {
        // // Cas de chargement
        // if (pointsState is AsyncLoading ||
        //     couponsState.status == CouponStatus.loading) {
        //   return const Center(child: CircularProgressIndicator());
        // }

        // // Cas d'erreur
        // if (pointsState is AsyncError) {
        //   return FailureWidget(
        //     err: (pointsState as AsyncError).error,
        //     onPressed: _refresh,
        //     show: false,
        //   );
        // }

        if (couponsState.status == CouponStatus.error) {
          return FailureWidget(
            err: couponsState.errorMessage ?? "Une erreur est survenue",
            onPressed: _refresh,
            show: false,
          );
        }

        // Cas de succès
        return RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  MyPoints(),
                  SizedBox(height: 10),
                  MyCoupon(),
                  SizedBox(height: 10),
                  Availablecoupon(),
                ],
              ),
            ),
          ),
        );
      }(),
    );
  }
}
