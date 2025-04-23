import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/deliverer/home/presentation/providers/deliverer_home_provider.dart';
import 'package:mobileapp/features/deliverer/home/presentation/providers/status_provider.dart';
import 'package:mobileapp/features/deliverer/home/presentation/widgets/available.dart';
import 'package:mobileapp/features/deliverer/home/presentation/widgets/not_available.dart';

class DelivererHomePage extends ConsumerWidget {
  const DelivererHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statAsync = ref.watch(delivererStatFutureProvider);
    final statusNotifier = ref.watch(statusNotifierProvider);
    final isDarkMode = ref.watch(darkModeProvider);
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final fontColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;

    final backgroundColor = isDarkMode ? kPrimaryBlack : kPrimaryWhite;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      color: backgroundColor,
      child: Column(
        children: [
          statusNotifier ? const AvailableWidget() : const NotAvailableWidget(),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.015,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.location_pin, color: kPrimaryRed),
                const SizedBox(width: 6),
                Flexible(
                  child: AutoSizeText(
                    'Village Agricole, Sidi Aich, Bejaia\n48° 51′ 24″ N, 2° 21′ 8″ E',
                    maxLines: 2,

                    style: TextStyle(fontSize: 13, color: fontColor),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: screenHeight * 0.03),

          const Align(
            alignment: Alignment.centerLeft,
            child: AutoSizeText(
              'Vos statistiques aujourd\'hui',
              maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),

          SizedBox(height: screenHeight * 0.02),

          statAsync.when(
            data: (data) {
              final orders = data.numberOfOrders.toString();
              final profit = data.profit.toStringAsFixed(2);

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatBox(context, ref, orders, 'Commandes'),
                  _buildStatBox(context, ref, '$profit DZ', 'Gains'),
                ],
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (e, _) => Text('Erreur: $e'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(
    BuildContext context,
    WidgetRef ref,
    String value,
    String label,
  ) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final isDarkMode = ref.watch(darkModeProvider);
    final backgroundColor = isDarkMode ? kPrimaryDark : kLightGrayWhite;
    final fontColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    return Container(
      width: screenWidth * 0.4,
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.02,
        horizontal: screenWidth * 0.03,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          AutoSizeText(
            value,
            maxLines: 1,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: kPrimaryRed,
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          AutoSizeText(label, maxLines: 1, style: TextStyle(color: fontColor)),
        ],
      ),
    );
  }
}
