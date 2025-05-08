import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';

class CartLimitAlertWidget extends ConsumerWidget {
  const CartLimitAlertWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final dialogHeight = screenHeight * 0.26;
    bool isDarkMode = ref.watch(darkModeProvider);

    return Dialog(
      backgroundColor: isDarkMode ? kPrimaryDark : kPrimaryWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: dialogHeight,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Limite de paniers atteinte",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Center(
                child: Text(
                  "Vous avez déjà utilisé les 5 paniers disponibles. "
                  "Veuillez valider au moins une commande avant d’en créer un nouveau.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color:
                        isDarkMode ? Colors.grey[300] : const Color(0xFF686868),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCircleButton(
                  icon: Icons.check,
                  color: const Color(0xFFE13838),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 20),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
