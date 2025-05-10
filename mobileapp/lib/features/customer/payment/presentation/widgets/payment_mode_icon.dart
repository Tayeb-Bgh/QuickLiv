import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';

class PaymentModeIcon extends ConsumerWidget {
  final String typePay;
  final Function handleOnTap;
  const PaymentModeIcon({
    super.key,
    required this.typePay,
    required this.handleOnTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    final Color color = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    return GestureDetector(
      onTap: () {
        handleOnTap();
      },
      child: Container(
        width: 55,
        padding: EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              typePay == "cash" ? Icons.money : Icons.payment,
              color: color,
              size: 15,
            ),
            AutoSizeText(
              typePay,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
              maxLines: 1,
              minFontSize: 8,
              maxFontSize: 10,
            ),
          ],
        ),
      ),
    );
  }
}
