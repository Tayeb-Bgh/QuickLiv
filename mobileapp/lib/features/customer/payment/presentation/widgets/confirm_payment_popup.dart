import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/constants.dart';

class PaymentConfirmationDialog extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onConfirm;

  const PaymentConfirmationDialog({
    super.key,
    required this.isDarkMode,
    required this.onConfirm,
  });

  @override
  State<PaymentConfirmationDialog> createState() =>
      _PaymentConfirmationDialogState();
}

class _PaymentConfirmationDialogState extends State<PaymentConfirmationDialog> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final fontColor = widget.isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    final backgroundColor = widget.isDarkMode ? kPrimaryDark : kPrimaryWhite;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.all(10),
      backgroundColor: backgroundColor,
      title: Center(
        child: const Text(
          "Confirmer le paiement.",
          style: TextStyle(
            color: kPrimaryRed,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          maxLines: 1,
        ),
      ),
      content:
          isLoading
              ? const SizedBox(
                height: 50,
                child: Center(
                  child: CircularProgressIndicator(color: kPrimaryRed),
                ),
              )
              : Text(
                textAlign: TextAlign.center,
                "Cette action est définitive. En confirmant, vous validez votre commande, qui sera alors en attente de prise en charge par un livreur. Si vous avez choisi le paiement en ligne, celui-ci sera immédiatement effectué.",
                style: TextStyle(color: fontColor),
              ),
      actionsAlignment: MainAxisAlignment.center,
      actions:
          isLoading
              ? []
              : [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Colors.black54,
                        ),
                        shape: WidgetStateProperty.all(const CircleBorder()),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.all(12),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.white),
                      onPressed: () async {
                        if (context.mounted) Navigator.of(context).pop();
                        widget.onConfirm();
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(kPrimaryRed),
                        shape: WidgetStateProperty.all(const CircleBorder()),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.all(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
    );
  }
}
