import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobileapp/features/customer/coupons_store/presentation/widgets/AvailableCoupon.dart';
import 'package:mobileapp/features/customer/coupons_store/presentation/widgets/MyCoupon.dart';
import 'package:mobileapp/features/customer/coupons_store/presentation/widgets/MyPoints.dart';

class CouponPage extends StatelessWidget {
  const CouponPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
}
