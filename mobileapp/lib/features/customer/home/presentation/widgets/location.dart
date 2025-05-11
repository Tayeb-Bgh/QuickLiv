import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/home/presentation/widgets/position_popup.dart';
import 'package:mobileapp/features/pick_location/providers/pick_location_providers.dart';

class Location extends ConsumerWidget {
  const Location({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDarkMode = ref.watch(darkModeProvider);
    final backgroundColor = isDarkMode ? kPrimaryDark : kSecondaryWhite;
    final fontColor1 = isDarkMode ? kSecondaryWhite : kPrimaryRed;
    final fontColor2 = isDarkMode ? kLightGray : kPrimaryBlack;

    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (ctx) => const PositionPopup());
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: 3,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: kLightGray),
          boxShadow: [
            BoxShadow(
              color: kPrimaryBlur,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_pin, color: kPrimaryRed),
            const SizedBox(width: 6),
            Flexible(
              child:
                  ref.watch(isDefaultPositionSelected)
                      ? ref
                          .watch(defaultPositionProvider)
                          .when(
                            data: (position) {
                              final addressAsync = ref.watch(
                                formattedAddressProvider(position!),
                              );
                              final String dmsCoordinates = formatPositionAsDMS(
                                position,
                              );

                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    addressAsync.when(
                                      data: (address) => address,
                                      error: (err, _) => "Loading ...",
                                      loading: () => "Loading ...",
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    minFontSize: 13,
                                    maxFontSize: 15,
                                    style: TextStyle(color: fontColor1),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ), // petit espace entre les lignes
                                  AutoSizeText(
                                    dmsCoordinates,
                                    maxLines: 1,
                                    minFontSize: 8,
                                    maxFontSize: 11,
                                    style: TextStyle(color: fontColor2),
                                  ),
                                ],
                              );
                            },
                            error: (error, stackTrace) {
                              return Column(
                                children: [
                                  AutoSizeText(
                                    'Erreur lors de la prise de l\'adresse.',
                                    maxLines: 1,
                                    minFontSize: 9,
                                    maxFontSize: 12,
                                    style: TextStyle(color: fontColor1),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ), // petit espace entre les lignes
                                  AutoSizeText(
                                    'Veuillez réessayer une autre adresse.',
                                    maxLines: 1,

                                    minFontSize: 8,
                                    maxFontSize: 11,
                                    style: TextStyle(color: fontColor2),
                                  ),
                                ],
                              );
                            },
                            loading: () {
                              return CircularProgressIndicator();
                            },
                          )
                      : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            ref
                                .watch(
                                  formattedAddressProvider(
                                    ref.watch(confirmedPositionProvider)!,
                                  ),
                                )
                                .when(
                                  data: (address) => address,
                                  error: (error, _) => "Chargement ...",
                                  loading: () => "Chargement ...",
                                ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            minFontSize: 13,
                            maxFontSize: 15,
                            style: TextStyle(color: fontColor1),
                          ),
                          const SizedBox(
                            height: 2,
                          ), // petit espace entre les lignes
                          AutoSizeText(
                            formatPositionAsDMS(
                              ref.watch(confirmedPositionProvider)!,
                            ),
                            maxLines: 1,

                            minFontSize: 8,
                            maxFontSize: 11,
                            style: TextStyle(color: fontColor2),
                          ),
                        ],
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
