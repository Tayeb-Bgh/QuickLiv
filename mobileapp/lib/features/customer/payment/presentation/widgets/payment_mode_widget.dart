import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/payment/presentation/providers/bank_card_provider.dart';
import 'package:mobileapp/features/customer/payment/presentation/widgets/form_button.dart';
import 'package:mobileapp/features/customer/payment/presentation/widgets/icon_text_field.dart';
import 'package:mobileapp/features/customer/payment/presentation/widgets/payment_mode_icon.dart';

// Providers
final paymentModeProvider = StateProvider<bool>(
  (ref) => false,
); // false = cash, true = card
final expansionStateProvider = StateProvider<bool>((ref) => false);

final isLoadingPay = StateProvider<bool>((ref) {
  return false;
});

final isVerified = StateProvider<bool>((ref) {
  return false;
});

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
            initiallyExpanded: ref.watch(expansionStateProvider),
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
            children: [
              if (isCardMode)
                _buildCardForm(isDarkMode, halfWidth, ref, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardForm(
    bool isDarkMode,
    double halfWidth,
    WidgetRef ref,
    BuildContext context,
  ) {
    void initValues() {
      ref.read(isLoadingPay.notifier).state = false;
      ref.read(isVerified.notifier).state = false;

      ref.read(cardNbTextProvider.notifier).state = "";
      ref.read(cardNbTextControllerProvider).text = "";

      ref.read(cvvNbTextProvider.notifier).state = "";
      ref.read(cvvNbControllerProvider).text = "";

      ref.read(dateExpTextProvider.notifier).state = "";
      ref.read(dateExpControllerProvider).text = "";

      ref.read(owernNameTextProvider.notifier).state = "";
      ref.read(owernNameControllerProvider).text = "";
    }

    void checkCard() {
      final String cardNb = ref.watch(cardNbTextProvider);
      final String cvv = ref.watch(cvvNbTextProvider);
      final String dateExp = ref.watch(dateExpTextProvider);
      final String ownerName = ref.watch(owernNameTextProvider);

      int status = ref
          .watch(checkCardProvider)
          .call(cardNb, cvv, dateExp, ownerName);

      final String mess =
          status == 1
              ? "Veuillez remplir tous les champs"
              : status == 2
              ? "Format de numéro de carte invalide"
              : status == 3
              ? "Format de cvv invalide"
              : status == 4
              ? "Format de date invalide"
              : status == 5
              ? "Cette carte n'existe  pas"
              : "Carte enregistrée avec succès";

      if (status == 5 || status == 0) {
        ref.read(isLoadingPay.notifier).state = true;
        Future.delayed(Duration(seconds: 3), () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(mess), duration: Duration(seconds: 2)),
          );
          ref.read(isLoadingPay.notifier).state = false;
          if (status == 0) {
            ref.read(isVerified.notifier).state = true;
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(mess), duration: Duration(seconds: 2)),
        );
      }
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              IconTextField(
                textProvider: cardNbTextProvider,
                controllerProvider: cardNbTextControllerProvider,
                label: "Numéro de la carte",
                prefixIcon: Icons.payment,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: halfWidth,
                    child: IconTextField(
                      textProvider: cvvNbTextProvider,
                      controllerProvider: cvvNbControllerProvider,
                      label: "CVV",
                      prefixIcon: Icons.tag_sharp,
                    ),
                  ),
                  SizedBox(
                    width: halfWidth,
                    child: IconTextField(
                      textProvider: dateExpTextProvider,
                      controllerProvider: dateExpControllerProvider,
                      label: "Date d'expiration",
                      prefixIcon: Icons.date_range,
                    ),
                  ),
                ],
              ),
              IconTextField(
                textProvider: owernNameTextProvider,
                controllerProvider: owernNameControllerProvider,
                label: "Prénom et NOM",
                prefixIcon: Icons.person,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FormButton(
                onClick: initValues,
                text: "Réinitialiser",
                bgColor: isDarkMode ? kPrimaryBlack : kPrimaryDark,
              ),
              ref.watch(isLoadingPay)
                  ? SizedBox(
                    height: 25,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryRed,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                      child: SizedBox(
                        width: 10,
                        height: 10,
                        child: CircularProgressIndicator(
                          color: kPrimaryWhite,
                          strokeWidth: 3,
                        ),
                      ),
                    ),
                  )
                  : ref.watch(isVerified)
                  ? Row(
                    children: [
                      Icon(Icons.verified, color: kPrimaryRed),
                      Text("Vérifié", style: TextStyle(color: kPrimaryRed)),
                    ],
                  )
                  : FormButton(
                    onClick: checkCard,
                    text: "Appliquer",
                    bgColor: kPrimaryRed,
                  ),
            ],
          ),
        ),
      ],
    );
  }
}
