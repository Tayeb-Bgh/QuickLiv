import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/deliverer/orders/business/entities/order_entity.dart';
import 'package:mobileapp/features/pick_location/providers/pick_location_providers.dart';

class ClientSection extends ConsumerWidget {
  const ClientSection({super.key, required this.order});
  final OrderEntity order;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isDarkMode = ref.watch(darkModeProvider);
    final fontColor = isDarkMode ? kWhiteGray : kPrimaryBlack;
    final backgroundColor = isDarkMode ? kSecondaryDark : kPrimaryWhite;
    final addressFont = isDarkMode ? kSecondaryWhite : kPrimaryRed;
    final dmsFont = isDarkMode ? kLightGray : kPrimaryBlack;

    LatLng? positionCust = LatLng(order.customer.latClt, order.customer.lngClt);

    return Column(
      children: [
        Text(
          'Client',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: fontColor,
          ),
        ),
        SizedBox(height: height * 0.006),
        Divider(color: fontColor, thickness: 3, height: 0),
        SizedBox(height: height * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.person, size: 18, color: fontColor),
                AutoSizeText(
                  order.customer.name,

                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: fontColor,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: fontColor,
                      style: BorderStyle.solid,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.phone, size: 14, color: fontColor),
                      const SizedBox(width: 5),
                      Text(
                        order.customer.phone,
                        style: TextStyle(fontSize: 12, color: fontColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(
                      ClipboardData(text: order.customer.phone),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Phone number copied to clipboard'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Icon(Icons.copy, size: 18, color: fontColor),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: height * 0.01),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.009,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: backgroundColor),
            boxShadow: [
              BoxShadow(
                color: backgroundColor,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_pin, color: kPrimaryRed),
              const SizedBox(width: 6),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      ref
                          .watch(formattedAddressProvider(positionCust))
                          .when(
                            data: (address) => address,
                            error: (error, _) => "Chargement ...",
                            loading: () => "Chargement ...",
                          ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      minFontSize: 13,
                      maxFontSize: 15,
                      style: TextStyle(color: addressFont),
                    ),
                    const SizedBox(height: 2), // petit espace entre les lignes
                    AutoSizeText(
                      /* formatPositionAsDMS(
                        ref.watch(confirmedPositionProvider)!,
                      ), */
                      formatPositionAsDMS(positionCust),

                      maxLines: 1,

                      minFontSize: 8,
                      maxFontSize: 11,
                      style: TextStyle(color: dmsFont),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: height * 0.01),
      ],
    );
  }
}
