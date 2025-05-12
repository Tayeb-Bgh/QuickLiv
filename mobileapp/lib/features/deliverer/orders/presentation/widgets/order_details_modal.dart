import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Add this to access ConsumerWidget
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/utils/location_provider.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';

import 'package:mobileapp/features/deliverer/orders/business/entities/business_entity.dart';
import 'package:mobileapp/features/deliverer/orders/business/entities/order_entity.dart';
import 'package:mobileapp/features/deliverer/orders/data/service/orders_service.dart';
import 'package:mobileapp/features/deliverer/orders/presentation/providers/orders_providers.dart';
import 'package:mobileapp/features/maps_example/polyline_current_to_destination.dart';
import 'package:mobileapp/features/maps_example/polyline_origin_to_destination.dart';
import 'package:mobileapp/features/pick_location/providers/pick_location_providers.dart';

class OrderDetailsModal extends ConsumerWidget {
  final OrderEntity order;
  final originDestParams;
  const OrderDetailsModal({
    super.key,
    required this.order,
    required this.originDestParams,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.8;
    final busns = order.busns;

    final isDarkMode = ref.watch(darkModeProvider);
    final fontColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    final backgroundColor = isDarkMode ? kSecondaryDark : kPrimaryWhite;
    LatLng? positionCust = LatLng(order.customer.latClt, order.customer.lngClt);
    LatLng? positionBusns = LatLng(busns.latBusns, busns.lngBusns);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        color: backgroundColor,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(cardWidth, fontColor, order),
            const SizedBox(height: 6),
            _buildStoreInfo(ref, cardWidth, fontColor, busns),
            const SizedBox(height: 8),
            _buildRouteLine(),
            const SizedBox(height: 4),
            _buildAddresses(fontColor, ref, positionCust, busns.address),
            const SizedBox(height: 10),
            _buildOrderMeta(fontColor),
            const SizedBox(height: 10),
            Center(
              child: Text(
                textAlign: TextAlign.center,
                "Itinéraire",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: fontColor,
                  fontSize: 16,
                ),
              ),
            ),
            const Divider(height: 0, thickness: 2),
            _buildMapSection(
              context,
              ref,
              screenHeight,
              screenWidth,
              fontColor,
              positionBusns,
              positionCust,
            ),
            SizedBox(
              width: cardWidth,
              child: _buildProductsList(
                screenHeight,
                fontColor,
                order.products,
              ),
            ),

            _buildTakeOrderButton(cardWidth, ref, context, order.id),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(double cardWidth, Color fontColor, OrderEntity order) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeText(
          "CMD N° - ${order.id}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: fontColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const AutoSizeText(
            "À prendre",
            maxLines: 1,
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildStoreInfo(
    ref,
    double cardWidth,
    Color fontColor,
    Business busns,
  ) {
    final distanceAsync = ref.watch(distanceInMetersProvider(originDestParams));
    final durationAsync = ref.watch(drivingDurationProvider(originDestParams));
    return Row(
      children: [
        CircleAvatar(
          radius: cardWidth * 0.1,
          backgroundImage: NetworkImage(busns.imgUrl),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              busns.name,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: fontColor,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.location_on_outlined, size: 16, color: fontColor),
                const SizedBox(width: 4),
                AutoSizeText(
                  distanceAsync is AsyncData<double>
                      ? "${toKilometers(distanceAsync.value)} Km"
                      : distanceAsync is AsyncError
                      ? "La distance n'a pu être calculée."
                      : "... Km", //
                  style: TextStyle(color: fontColor),
                ),
                const SizedBox(width: 10),
                Icon(Icons.timer_outlined, size: 16, color: fontColor),
                const SizedBox(width: 4),
                AutoSizeText(
                  durationAsync is AsyncData<int>
                      ? formatDurationInReadableText(durationAsync.value)
                      : "....",
                  style: TextStyle(color: fontColor),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRouteLine() {
    return const Row(
      children: [
        Icon(Icons.storefront, size: 24, color: Colors.grey),
        SizedBox(width: 4),
        Expanded(
          child: DottedLine(
            direction: Axis.horizontal,
            lineLength: double.infinity,
            lineThickness: 2.0,
            dashLength: 4.0,
            dashColor: Colors.grey,
          ),
        ),
        Icon(Icons.location_on, size: 24, color: Colors.red),
      ],
    );
  }

  Widget _buildAddresses(Color fontColor, ref, positionCust, String busnsAddr) {
    final AsyncValue<String> asyncAddress = ref.watch(
      formattedAddressProvider(positionCust),
    );

    return asyncAddress.when(
      data: (address) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: AutoSizeText(
                busnsAddr,
                maxLines: 1,
                minFontSize: 10,
                style: TextStyle(
                  fontSize: 12,
                  color: fontColor.withOpacity(0.6),
                ),
              ),
            ),
            Flexible(
              child: AutoSizeText(
                address,
                textAlign: TextAlign.end,
                maxLines: 1,
                minFontSize: 10,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: fontColor,
                ),
              ),
            ),
          ],
        );
      },
      error: (error, _) {
        return _buildLoadingOrErrorRow(fontColor, busnsAddr, "Erreur...");
      },
      loading: () {
        return _buildLoadingOrErrorRow(fontColor, busnsAddr, "Chargement...");
      },
    );
  }

  Widget _buildLoadingOrErrorRow(
    Color fontColor,
    String busnsAddr,
    String rightText,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: AutoSizeText(
            busnsAddr,
            maxLines: 1,
            minFontSize: 10,
            style: TextStyle(fontSize: 12, color: fontColor.withOpacity(0.6)),
          ),
        ),
        Flexible(
          child: AutoSizeText(
            rightText,
            textAlign: TextAlign.end,
            maxLines: 1,
            minFontSize: 10,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: fontColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderMeta(Color fontColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.access_time, size: 16, color: fontColor),
            const SizedBox(width: 4),
            AutoSizeText(
              DateFormat('HH:mm').format(order.time),
              maxLines: 1,
              style: TextStyle(color: fontColor),
            ),
          ],
        ),
        Row(
          children: [
            Icon(Icons.inbox, size: 16, color: fontColor),
            const SizedBox(width: 4),
            AutoSizeText(
              order.type,
              maxLines: 1,
              style: TextStyle(color: fontColor),
            ),
          ],
        ),
        AutoSizeText(
          "${order.delPrice.toStringAsFixed(0)} DZD",
          maxLines: 1,
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildMapSection(
    BuildContext context,
    WidgetRef ref,
    double height,
    double width,
    Color fontColor,
    LatLng positionBusns,
    LatLng positionCust,
  ) {
    final mapViewType = ref.watch(mapViewProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.005),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(10),
                backgroundColor:
                    mapViewType == MapViewType.business
                        ? kPrimaryRed
                        : Colors.transparent,
                foregroundColor:
                    mapViewType == MapViewType.business
                        ? Colors.white
                        : kPrimaryRed,
                side: const BorderSide(color: kPrimaryRed),
                elevation: 0,
              ),
              onPressed: () {
                ref.read(mapViewProvider.notifier).state = MapViewType.business;
              },
              child: const AutoSizeText(
                "Actuel → Commerce",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(10),
                backgroundColor:
                    mapViewType == MapViewType.client
                        ? kPrimaryRed
                        : Colors.transparent,
                foregroundColor:
                    mapViewType == MapViewType.client
                        ? Colors.white
                        : kPrimaryRed,
                side: const BorderSide(color: kPrimaryRed),
                elevation: 0,
              ),
              onPressed: () {
                ref.read(mapViewProvider.notifier).state = MapViewType.client;
              },
              child: const AutoSizeText(
                "Commerce → Client",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.01),

        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: width * 0.9,
            height: height * 0.2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child:
                      mapViewType == MapViewType.business
                          ? GoogleMapsPageToDest(destinationPos: positionBusns)
                          : GoogleMapsPosToPos(
                            pointA: positionBusns,
                            marketPos: positionCust,
                          ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductsList(double height, Color fontColor, List products) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Produits",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: fontColor,
                fontSize: 16,
              ),
            ),
          ),
          const Divider(height: 0, thickness: 2),
          SizedBox(height: height * 0.01),
          Container(
            constraints: BoxConstraints(maxHeight: height * 0.14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Scrollbar(
              thickness: 8,
              thumbVisibility: true,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      products
                          .map<Widget>(
                            (product) => _buildProductText(
                              product.name,
                              product.quantity,
                              fontColor,
                              product.unitProd,
                            ),
                          )
                          .toList(),
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.01),
        ],
      ),
    );
  }

  Widget _buildTakeOrderButton(double cardWidth, ref, context, idOrd) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: SizedBox(
          width: cardWidth * 0.6,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: kPrimaryRed),
            onPressed: () async {
  final currenPos = await ref.read(locationProvider.future);
  final updateStatus = ref.read(updateOrderStatusProvider);
  
  try {
    await updateStatus(
      idOrd,
      "1",
      currenPos.latitude,
      currenPos.longitude,
    );
    await ref.read(assignOrderProvider)(idOrd);

    // Update state BEFORE pop
    ref.read(selectedCategoryIndexProvider.notifier).state = false;
    ref.read(isTakenProvider.notifier).state = true;

    // Optional: await fetchCurrentOrderProvider to ensure UI updates
    await ref.refresh(fetchCurrentOrderProvider.future);

    Navigator.pop(context);
  } catch (e) {
    log("Erreur lors de l'assignation: $e");
    // Optional: Show a SnackBar or Dialog for feedback
  }
},

            child: const AutoSizeText(
              "Prendre la commande",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kPrimaryWhite,
              ),
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductText(
    String productName,
    int quantity,
    Color fontColor,
    bool unitProd,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
      child: Text(
        unitProd ? "x$quantity g $productName" : "x$quantity  $productName",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: fontColor,
        ),
      ),
    );
  }
}
