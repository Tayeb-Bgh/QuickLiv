import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/payment/presentation/widgets/styles_text_field.dart';

class UseCouponWidget extends ConsumerWidget {
  const UseCouponWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);
    final Color bgColor = isDarkMode ? kSecondaryDark : kLightGray;
    final Color textColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;

    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        splashColor: Colors.transparent, // Désactive le ripple
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
            title: Text(
              'Utiliser un coupon',
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
            trailing: Consumer(
              builder: (context, ref, child) {
                final isExpanded = ref.watch(expansionTileStateProvider);
                return AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0,
                  duration: Duration(milliseconds: 200),
                  child: Icon(Icons.expand_more, color: textColor, size: 30),
                );
              },
            ),
            leading: Icon(Symbols.card_giftcard, color: textColor),
            onExpansionChanged: (expanded) {
              ref.read(expansionTileStateProvider.notifier).state = expanded;
            },
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: StylesTextField(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 25,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryRed,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                        onPressed: () {
                          // Handle submission here
                        },
                        child: Text(
                          'Appliquer',
                          style: TextStyle(color: kSecondaryWhite),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final expansionTileStateProvider = StateProvider<bool>((ref) => false);
