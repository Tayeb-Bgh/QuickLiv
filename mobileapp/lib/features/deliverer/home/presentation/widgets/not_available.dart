import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/deliverer/home/presentation/providers/status_provider.dart';
import 'package:mobileapp/features/deliverer/home/presentation/widgets/not_available_statue_popup.dart';

class NotAvailableWidget extends ConsumerWidget {
  const NotAvailableWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final isDarkMode = ref.watch(darkModeProvider);
    final fontColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    return Container(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(screenWidth * 0.03),
            decoration: BoxDecoration(
              color: KSecondaryRed,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kPrimaryRed),
            ),
            child: Row(
              children: const [
                Icon(Icons.error_outline, color: kPrimaryRed),
                SizedBox(width: 8),
                Expanded(
                  child: AutoSizeText(
                    'Vous êtes actuellement hors service',
                    maxLines: 1,
                    minFontSize: 12,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: screenHeight * 0.04),

          AutoSizeText(
            'Activez votre statut afin de recevoir de nouvelles commandes pour commencer à travailler',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(fontSize: 13, color: fontColor),
          ),

          SizedBox(height: screenHeight * 0.03),

          GestureDetector(
            onTap: () {
              // 👇 Correct usage via notifier method
              showReadyStatusConfirmationDialog(context, ref);
              // ref.read(statusNotifierProvider.notifier).updateStatus(true);
            },
            child: CircleAvatar(
              radius: screenHeight * 0.06,
              backgroundColor: kPrimaryRed,
              child: Icon(
                Icons.power_settings_new,
                size: screenHeight * 0.1,
                color: Colors.white,
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.01),

          const AutoSizeText(
            'Hors service',
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: kPrimaryBlack,
            ),
          ),
          const AutoSizeText(
            'Appuyer pour activer',
            maxLines: 1,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
