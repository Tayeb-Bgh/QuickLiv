import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/utils/location_provider.dart';
import 'package:mobileapp/features/customer/cart_popup/data/services/cart_service.dart';
import 'package:mobileapp/features/customer/cart_popup/presentation/providers/cart_provider.dart';
import 'package:mobileapp/features/customer/payment/presentation/providers/bank_card_provider.dart';
import 'package:mobileapp/features/customer/payment/presentation/providers/payment_provider.dart';
import 'package:mobileapp/features/customer/payment/presentation/widgets/bill_widget.dart';
import 'package:mobileapp/features/customer/payment/presentation/widgets/maps_widget.dart';
import 'package:mobileapp/features/customer/payment/presentation/widgets/payment_mode_widget.dart';
import 'package:mobileapp/features/customer/payment/presentation/widgets/payment_processing_popup.dart';
import 'package:mobileapp/features/customer/payment/presentation/widgets/payment_widget.dart';
import 'package:mobileapp/features/customer/payment/presentation/widgets/confirm_payment_popup.dart';

class PaymentPage extends ConsumerWidget {
  void insertOrder(WidgetRef ref) async {
    if (ref.watch(paymentModeProvider) && !ref.watch(isVerified)) return;

    ref.read(isValidPayment.notifier).state = true;
    ref.read(loadedOnlinePayment.notifier).state = false;
    ref.read(loadingOnlinePayment.notifier).state = false;
    ref.read(uploadingOrder.notifier).state = false;
    ref.read(uploadedOrder.notifier).state = false;

    final cart = ref.watch(actualCartProvider);
    final coupon = ref.watch(usedCouponProvider);
    final currentPos = await ref.watch(locationProvider.future);
    if (cart == null || currentPos == null) return;

    int? transNbr =
        ref.watch(paymentModeProvider) &&
                ref.watch(isVerified) &&
                ref.watch(paymentModeProvider)
            ? 1
            : null;

    if (transNbr == 1) {
      ref.read(loadingOnlinePayment.notifier).state = true;
      Future.delayed(const Duration(seconds: 2), () {
        ref.read(loadingOnlinePayment.notifier).state = false;
        ref.read(loadedOnlinePayment.notifier).state = true;
      });

      final double total =
          ref.watch(billInformationsProvider)["total"].toDouble();
      final String selectedCardNb = ref.watch(cardNbTextProvider);
      final double amount =
          ref
              .watch(bankCardsProvider)
              .where((cb) => cb.cardNb == selectedCardNb)
              .first
              .sold;

      final difference = amount - total;
      if (difference < 0) ref.read(isValidPayment.notifier).state = false;
    }

    ref.read(uploadingOrder.notifier).state = true;

    final deliveryPrice =
        ref.watch(billInformationsProvider)["totalDeliv"].toDouble() -
        ref.watch(billInformationsProvider)["totalReduc"].toDouble();

    final params = InsertOrderParams(
      cart: cart,
      coupon: coupon,
      custLat: currentPos.latitude,
      custLng: currentPos.longitude,
      deliveryPrice: deliveryPrice,
      transNbr: transNbr,
    );

    if (ref.watch(isValidPayment)) {
      await CartService.clearCart(cart.idBusns.toString());
      await ref.read(cartsProvider.notifier).reload();
      ref.read(insertOrderFamilyProvider(params));

      ref.read(uploadingOrder.notifier).state = false;
      ref.read(uploadedOrder.notifier).state = true;
    }
  }

  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);
    final width = MediaQuery.of(context).size.width;
    final billInformations = ref.watch(billInformationsProvider);

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
              //const SizedBox(height: 300, child: MapsWidget()),
              const SizedBox(height: 20),
              const PaymentWidget(),
              const SizedBox(height: 20),
              BillWidget(
                totalProd:
                    billInformations["totalProducts"] != null
                        ? billInformations["totalProducts"].toDouble()
                        : 0,
                totalDeliv:
                    billInformations["totalDeliv"] != null
                        ? billInformations["totalDeliv"].toDouble()
                        : 0,
                totalReduc:
                    billInformations["totalReduc"] != null
                        ? billInformations["totalReduc"].toDouble()
                        : 0,
                total:
                    billInformations["total"] != null
                        ? billInformations["total"].toDouble()
                        : 0,
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
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (dialogContext) {
                  return PaymentConfirmationDialog(
                    isDarkMode: ref.watch(darkModeProvider),
                    onConfirm: () {
                      if (ref.watch(paymentModeProvider) &&
                          !ref.watch(isVerified))
                        return;

                      insertOrder(ref);
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (dialogContext) {
                          return PaymentProcessingPopup(
                            isDarkMode: isDarkMode,
                            onConfirm: () {},
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
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

final uploadingOrder = StateProvider<bool>((ref) {
  return false;
});

final uploadedOrder = StateProvider<bool>((ref) {
  return false;
});

final loadingOnlinePayment = StateProvider<bool>((ref) {
  return false;
});

final loadedOnlinePayment = StateProvider<bool>((ref) {
  return false;
});

final isValidPayment = StateProvider<bool>((ref) {
  return true;
});
