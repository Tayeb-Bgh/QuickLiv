import 'package:flutter/material.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/deliverer/home/presentation/providers/status_provider.dart';

void showReadyStatusConfirmationDialog(BuildContext context, ref) {
  final isDarkMode = ref.watch(darkModeProvider);
  final fontColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
  final backgroundColor = isDarkMode ? kPrimaryDark : kPrimaryWhite;

  bool isLoading = false;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.all(10),
            backgroundColor: backgroundColor,
            title: Text(
              "Confirmer la désactivation",
              style: const TextStyle(
                color: kPrimaryGreen,
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
              maxLines: 1,
            ),
            content:
                isLoading
                    ? const SizedBox(
                      height: 50,
                      child: Center(
                        child: CircularProgressIndicator(color: kPrimaryGreen),
                      ),
                    )
                    : Text(
                      textAlign: TextAlign.center,
                      "En confirmant votre choix, vous arrêtez votre service.",
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
                            onPressed: () => Navigator.of(dialogContext).pop(),
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                Colors.black54,
                              ),
                              shape: WidgetStateProperty.all(
                                const CircleBorder(),
                              ),
                              padding: WidgetStateProperty.all(
                                const EdgeInsets.all(12),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.check, color: Colors.white),
                            onPressed: () async {
                              setState(() => isLoading = true);

                              await ref
                                  .read(statusNotifierProvider.notifier)
                                  .updateStatus(false);

                              Navigator.of(dialogContext).pop();
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                               kPrimaryGreen,
                              ),
                              shape: WidgetStateProperty.all(
                                const CircleBorder(),
                              ),
                              padding: WidgetStateProperty.all(
                                const EdgeInsets.all(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
          );
        },
      );
    },
  );
}
