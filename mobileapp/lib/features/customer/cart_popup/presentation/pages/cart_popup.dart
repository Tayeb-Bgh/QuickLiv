import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/cart_popup/data/services/cart_service.dart';
import 'package:mobileapp/features/customer/cart_popup/presentation/providers/cart_provider.dart';
import 'package:mobileapp/features/customer/cart_popup/presentation/widgets/cart_empty_popup.dart';
import 'package:mobileapp/features/customer/cart_popup/presentation/widgets/overview_cart.dart';
import 'package:mobileapp/features/customer/cart_popup/presentation/widgets/product_card_horiz.dart';
import 'package:mobileapp/features/customer/payment/presentation/pages/payment_page.dart';
import 'package:mobileapp/features/customer/payment/presentation/providers/bank_card_provider.dart';
import 'package:mobileapp/features/customer/payment/presentation/providers/payment_provider.dart';
import 'package:mobileapp/features/customer/payment/presentation/widgets/payment_mode_widget.dart';
import 'package:mobileapp/features/customer/payment/presentation/widgets/use_coupon_widget.dart';

class CartPopup extends ConsumerStatefulWidget {
  const CartPopup({super.key});

  @override
  ConsumerState<CartPopup> createState() => _CartPopupState();
}

class _CartPopupState extends ConsumerState<CartPopup> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(darkModeProvider);
    final cartsAsync = ref.watch(cartsProvider);
    final backgroundColor = isDarkMode ? kPrimaryDark : kPrimaryWhite;
    final cardColor = isDarkMode ? kSecondaryDark : kLightGrayWhite;
    final fontColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    return AnimatedPadding(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.65,
        maxChildSize: 0.96,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const SizedBox(height: 8),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(5, (index) {
                      bool isSelected = selectedIndex == index;
                      return Flexible(
                        flex: isSelected ? 2 : 1,
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.5),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  isSelected ? kPrimaryRed : cardColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),

                            child: AutoSizeText(
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              isSelected
                                  ? 'Panier ${index + 1}'
                                  : '${index + 1}',
                              style: TextStyle(
                                color:
                                    isDarkMode
                                        ? kPrimaryWhite
                                        : isSelected
                                        ? kPrimaryWhite
                                        : kPrimaryDark,

                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 8),

                cartsAsync.when(
                  data: (carts) {
                    if (carts.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                size: 80,
                                color: fontColor.withOpacity(0.5),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Panier Vide',
                                style: TextStyle(
                                  color: fontColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    if (selectedIndex >= carts.length) {
                      return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                size: 80,
                                color: fontColor.withOpacity(0.5),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Panier Vide',
                                style: TextStyle(
                                  color: fontColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final cart = carts[selectedIndex];

                    return Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    OverviewCart(
                                      ref: ref,
                                      imgUrl: cart.imgUrl,
                                      name: cart.nameBusns,
                                      delPrice: cart.delivPrice.toStringAsFixed(
                                        2,
                                      ),
                                      totalPrice: (cart.prodPrice +
                                              cart.delivPrice)
                                          .toStringAsFixed(2),
                                      prodPrice: cart.prodPrice.toStringAsFixed(
                                        2,
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    for (var product in cart.products) ...{
                                      ProductCardHoriz(
                                        product,
                                        selectedIndex + 1,
                                      ),
                                    },
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kPrimaryDark,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: const EdgeInsets.all(12),
                                  ),
                                  onPressed: () async {
                                    await showConfirmEmptyCartDialog(
                                      context,
                                      ref,
                                      onConfirm: () async {
                                        await CartService.clearCart(
                                          cart.idBusns.toString(),
                                        );
                                        await ref
                                            .read(cartsProvider.notifier)
                                            .reload();
                                      },
                                    );
                                  },
                                  child: const Text(
                                    'Vider le panier',
                                    style: TextStyle(
                                      color: kPrimaryWhite,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),

                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kPrimaryRed,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: EdgeInsets.all(12),
                                  ),
                                  onPressed: () {
                                    ref
                                        .watch(usedCouponProvider.notifier)
                                        .state = null;
                                    ref.read(isLoadedCoup.notifier).state =
                                        false;
                                    ref.read(couponControllerProvider).text =
                                        "";
                                    ref
                                        .read(couponTextProvider.notifier)
                                        .state = "";

                                    ref.read(isLoadingPay.notifier).state =
                                        false;
                                    ref.read(isVerified.notifier).state = false;

                                    ref
                                        .read(cardNbTextProvider.notifier)
                                        .state = "";
                                    ref
                                        .read(cardNbTextControllerProvider)
                                        .text = "";

                                    ref.read(cvvNbTextProvider.notifier).state =
                                        "";
                                    ref.read(cvvNbControllerProvider).text = "";

                                    ref
                                        .read(dateExpTextProvider.notifier)
                                        .state = "";
                                    ref.read(dateExpControllerProvider).text =
                                        "";

                                    ref
                                        .read(owernNameTextProvider.notifier)
                                        .state = "";
                                    ref.read(owernNameControllerProvider).text =
                                        "";
                                    ref
                                        .watch(actualCartProvider.notifier)
                                        .state = cart;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PaymentPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Valider la commande',
                                    style: TextStyle(
                                      color: kPrimaryWhite,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  error: (error, stackTrace) {
                    return const Text('error');
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(color: kPrimaryRed),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
