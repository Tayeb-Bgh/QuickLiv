import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/payment/presentation/widgets/form_button.dart';
import 'package:mobileapp/features/customer/payment/presentation/widgets/icon_text_field.dart';
import 'package:mobileapp/features/customer/payment/presentation/widgets/payment_mode_icon.dart';

// Providers
final paymentModeProvider = StateProvider<bool>(
  (ref) => false,
); // false = cash, true = card
final expansionStateProvider = StateProvider<bool>((ref) => false);

class PaymentModeWidget extends ConsumerWidget {
  const PaymentModeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Configuration
    final isDarkMode = ref.watch(darkModeProvider);
    final isCardMode = ref.watch(paymentModeProvider);
    final isExpanded = ref.watch(expansionStateProvider);

    // Styles
    final bgColor = isDarkMode ? kSecondaryDark : kLightGray;
    final textColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    final width = MediaQuery.of(context).size.width;
    final halfWidth = width / 2.7;

    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: ExpansionTile(
            initiallyExpanded: false, // Toujours fermé au départ
            onExpansionChanged: (expanded) {
              // L'expansion ne fonctionne qu'en mode carte
              if (isCardMode) {
                ref.read(expansionStateProvider.notifier).state = expanded;
              }
            },
            leading: Icon(Symbols.payment, color: textColor),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mode de paiement',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  isCardMode ? "Carte bancaire" : "Paiement en espèces",
                  style: TextStyle(
                    color: textColor.withOpacity(0.7),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PaymentModeIcon(
                  typePay: isCardMode ? "carte" : "cash",
                  handleOnTap: () {
                    // Changement de mode et fermeture forcée
                    ref.read(paymentModeProvider.notifier).state = !isCardMode;
                    ref.read(expansionStateProvider.notifier).state = false;
                  },
                ),
                const SizedBox(width: 8),
                // Flèche d'expansion (visible seulement en mode carte)
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.expand_more,
                    color: isCardMode ? textColor : textColor.withOpacity(0.1),
                    size: 30,
                  ),
                ),
              ],
            ),
            children: [if (isCardMode) _buildCardForm(isDarkMode, halfWidth)],
          ),
        ),
      ),
    );
  }

  Widget _buildCardForm(bool isDarkMode, double halfWidth) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              IconTextField(
                label: "Numéro de la carte",
                prefixIcon: Icons.payment,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: halfWidth,
                    child: IconTextField(
                      label: "CVV",
                      prefixIcon: Icons.tag_sharp,
                    ),
                  ),
                  SizedBox(
                    width: halfWidth,
                    child: IconTextField(
                      label: "Date d'expiration",
                      prefixIcon: Icons.date_range,
                    ),
                  ),
                ],
              ),
              IconTextField(label: "Prénom et NOM", prefixIcon: Icons.person),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FormButton(
                text: "Réinitialiser",
                bgColor: isDarkMode ? kPrimaryBlack : kPrimaryDark,
              ),
              FormButton(text: "Appliquer", bgColor: kPrimaryRed),
            ],
          ),
        ),
      ],
    );
  }
}
