import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/payment/presentation/widgets/bill_widget.dart';
import 'package:mobileapp/features/customer/payment/presentation/widgets/maps_widget.dart';
import 'package:mobileapp/features/customer/payment/presentation/widgets/payment_widget.dart';

class PaymentPage extends ConsumerWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: isDarkMode ? kPrimaryDark : kSecondaryWhite,
      appBar: AppBar(
        backgroundColor: kPrimaryRed,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kPrimaryWhite),
          onPressed: () {
            Navigator.pop(context); // Go back when pressed
          },
        ),
        centerTitle: true,
        title: const Text(
          "Paiement",
          style: TextStyle(
            color: kSecondaryWhite,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding * width * 2,
            vertical: kDefaultPadding * width,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 👉 Map avec hauteur fixe
              const SizedBox(height: 300, child: MapsWidget()),
              const SizedBox(height: 20),
              const PaymentWidget(),
              const SizedBox(height: 20),
              const BillWidget(
                total: 2700,
                totalProd: 2700,
                totalDeliv: 400,
                totalReduc: 200,
              ),
              const SizedBox(
                height: 80,
              ), // espace pour ne pas être caché par le bouton
            ],
          ),
        ),
      ),

      /// 👉 Bouton fixe en bas
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(15),
        color: isDarkMode ? kPrimaryDark : kSecondaryWhite,
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryRed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "Confirmer le paiement",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kSecondaryWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
