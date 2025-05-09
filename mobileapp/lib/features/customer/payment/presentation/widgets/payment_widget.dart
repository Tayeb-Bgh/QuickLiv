import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/payment/presentation/widgets/payment_mode_widget.dart';
import 'package:mobileapp/features/customer/payment/presentation/widgets/use_coupon_widget.dart';

import 'package:material_symbols_icons/symbols.dart';

class PaymentWidget extends ConsumerWidget {
  const PaymentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);
    final width = MediaQuery.of(context).size.width;

    final Color sectionTxtColor = isDarkMode ? kLightGray : kMediumGray;

    return Column(
      children: [
        Text(
          "Paiement",
          style: TextStyle(
            color: sectionTxtColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Container(
          width: width,
          height: 5,
          decoration: BoxDecoration(
            color: sectionTxtColor,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        SizedBox(height: 10),
        PaymentModeWidget(),
        SizedBox(height: 10),
        UseCouponWidget(),
      ],
    );
  }
}
