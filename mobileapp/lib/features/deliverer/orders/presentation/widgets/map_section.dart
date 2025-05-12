import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/params/origin_dest_params.dart';
import 'package:mobileapp/core/utils/location_provider.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';
import 'package:mobileapp/features/deliverer/orders/business/entities/order_entity.dart';
import 'package:mobileapp/features/deliverer/orders/presentation/pages/maps.dart';

import 'package:mobileapp/features/maps_example/polyline_current_to_destination.dart';

class MapSection extends ConsumerWidget {
  const MapSection({super.key, required this.order, required this.isClt});
  final OrderEntity order;
  final bool isClt;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isDarkMode = ref.watch(darkModeProvider);
    final fontColor = isDarkMode ? kWhiteGray : kDarkGray;
    final latLng =
        isClt
            ? LatLng(order.customer.latClt, order.customer.lngClt)
            : LatLng(order.busns.latBusns, order.busns.lngBusns);
    final originDestParams = OriginDestParams(
      origin: ref
          .watch(locationProvider)
          .when(
            data: (pos) => pos!,
            error: (error, _) => LatLng(36.7515126, 5.0371626),
            loading: () => LatLng(36.7515126, 5.0371626),
          ), // example: Algiers
      destination: latLng, // example: Bejaia
    );

    final distanceAsync = ref.watch(distanceInMetersProvider(originDestParams));
    final durationAsync = ref.watch(drivingDurationProvider(originDestParams));

    return Column(
      children: [
        Text(
          'Itinéraire',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: fontColor,
          ),
        ),
        SizedBox(height: height * 0.006),
        Divider(color: fontColor, thickness: 3, height: 0),
        SizedBox(height: height * 0.01),

        SizedBox(height: height * 0.01),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: width * 0.7,
            height: height * 0.2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: GoogleMapsPageToDest(destinationPos: latLng),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: height * 0.01),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Icon(Icons.location_on_outlined, color: fontColor, size: 16),
                AutoSizeText(
                  distanceAsync.when(
                    data:
                        (distance) =>
                            "Km à parcourir: ${toKilometers(distance)} ",
                    error: (err, _) => "La distance n'a pu être claculée.",
                    loading: () => "Calcul de la distance en cours ...",
                  ),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: fontColor,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.timelapse, color: fontColor, size: 16),
                AutoSizeText(
                  durationAsync.when(
                    data:
                        (seconds) =>
                            "Durée estimée: ${formatDurationInReadableText(seconds)}",
                    error: (err, _) => "La durée n'a pu être claculée.",
                    loading: () => "Calcul de la durée en cours ...",
                  ),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: fontColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
