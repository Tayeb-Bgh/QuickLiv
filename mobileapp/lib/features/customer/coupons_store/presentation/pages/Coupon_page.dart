import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/failure/failure.dart';
import 'package:mobileapp/features/auth/presentation/providers/auth_provider.dart';
import 'package:mobileapp/features/customer/coupons_store/presentation/providers/Coupon_provider.dart';
import 'package:mobileapp/features/customer/coupons_store/presentation/providers/Point_provider.dart';
import 'package:mobileapp/features/customer/coupons_store/presentation/widgets/AvailableCoupon.dart';
import 'package:mobileapp/features/customer/coupons_store/presentation/widgets/MyCoupon.dart';
import 'package:mobileapp/features/customer/coupons_store/presentation/widgets/MyPoints.dart';
import 'package:mobileapp/features/auth/presentation/pages/login_page.dart';

class CouponPage extends ConsumerStatefulWidget {
  const CouponPage({super.key});

  @override
  ConsumerState<CouponPage> createState() => _CouponPageState();
}

class _CouponPageState extends ConsumerState<CouponPage> {
  Future<void> _refresh() async {
    await ref.refresh(couponProvider.notifier).fetchCoupons();
    ref.refresh(pointProvider.notifier).refreshPoints();
  }

  bool hasShownAuthDialog = false;

  void _showAuthenticationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Authentification requise'),
          content: Text('Vous devez être connecté pour accéder à cette page.'),
          actions: [
            TextButton(
              child: Text('Se connecter'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final couponsState = ref.watch(couponProvider);
    final isDarkMode = ref.watch(darkModeProvider);
    

    Widget buildCouponContent() {
      if (couponsState.status == CouponStatus.error) {
        return FailureWidget(
          err: couponsState.errorMessage ?? "Une erreur est survenue",
          onPressed: _refresh,
          show: false,
        );
      }

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
    }

    return Scaffold(
      backgroundColor: isDarkMode ? kPrimaryBlack : kSecondaryWhite,
      body:  buildCouponContent(),
    );
  }
}
