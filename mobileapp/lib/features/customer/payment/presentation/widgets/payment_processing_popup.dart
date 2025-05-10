import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/payment/presentation/pages/payment_page.dart';

class PaymentProcessingPopup extends ConsumerStatefulWidget {
  final bool isDarkMode;
  final VoidCallback onConfirm;

  const PaymentProcessingPopup({
    super.key,
    required this.isDarkMode,
    required this.onConfirm,
  });

  @override
  ConsumerState<PaymentProcessingPopup> createState() =>
      _PaymentProcessingPopupState();
}

class _PaymentProcessingPopupState
    extends ConsumerState<PaymentProcessingPopup> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final fontColor = widget.isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    final backgroundColor = widget.isDarkMode ? kPrimaryDark : kPrimaryWhite;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 200),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Traitement de la commande.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kPrimaryRed,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (ref.watch(loadingOnlinePayment))
                        _buildStatusRow(
                          "Paiement en cours",
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: kPrimaryRed,
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                      if (ref.watch(loadedOnlinePayment) &&
                          ref.watch(isValidPayment))
                        _buildStatusRow(
                          "Paiement réussi",
                          const Icon(Icons.check, color: kPrimaryRed),
                        ),
                      if (ref.watch(loadedOnlinePayment) &&
                          !ref.watch(isValidPayment))
                        _buildStatusRow(
                          "Paiement échoué",
                          const Icon(Icons.close, color: kPrimaryRed),
                        ),
                      if (ref.watch(uploadedOrder))
                        _buildStatusRow(
                          "Commande réussie",
                          const Icon(Icons.check, color: kPrimaryRed),
                        ),
                      if (!ref.watch(isValidPayment))
                        _buildStatusRow(
                          "Commande échouée",
                          const Icon(Icons.close, color: kPrimaryRed),
                        ),
                      if (ref.watch(uploadingOrder) &&
                          ref.watch(isValidPayment))
                        _buildStatusRow(
                          "Commande en cours",
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: kPrimaryRed,
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (!ref.watch(isValidPayment) ||
                  ref.watch(isValidPayment) && !isLoading)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIconButton(Icons.check, kPrimaryRed, () async {
                      widget.onConfirm();
                      if (context.mounted) Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    }),
                  ],
                ),
              if (isLoading)
                const SizedBox(
                  height: 50,
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: kPrimaryRed,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusRow(String text, Widget icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              color: widget.isDarkMode ? kPrimaryWhite : kPrimaryBlack,
            ),
          ),
          icon,
        ],
      ),
    );
  }

  Widget _buildIconButton(
    IconData icon,
    Color bgColor,
    VoidCallback onPressed,
  ) {
    return IconButton(
      icon: Icon(icon, color: Colors.white),
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(bgColor),
        shape: WidgetStateProperty.all(const CircleBorder()),
        padding: WidgetStateProperty.all(const EdgeInsets.all(12)),
      ),
    );
  }
}
