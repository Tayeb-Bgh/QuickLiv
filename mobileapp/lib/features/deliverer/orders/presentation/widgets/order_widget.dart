import 'dart:developer';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/deliverer/orders/business/entities/order_entity.dart';
import 'package:mobileapp/features/deliverer/orders/presentation/widgets/order_details_modal.dart';

class OrderWidget extends StatelessWidget {
  OrderWidget({super.key, required this.ref, required this.order});
  final WidgetRef ref;
  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final cardHeight = screenHeight * 0.4;
    final cardWidth = MediaQuery.of(context).size.width * 0.9;
    final isDarkMode = ref.watch(darkModeProvider);
    final busns = order.busns;

    final fontColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    final backgroundColor = isDarkMode ? kSecondaryDark : kPrimaryWhite;
    log('text');
    return Container(
      height: cardHeight,
      width: cardWidth,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: AutoSizeText(
                      "À prendre",
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  CircleAvatar(
                    radius: cardHeight * 0.09,
                    backgroundImage: NetworkImage(busns.imgUrl),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: AutoSizeText(
                      busns.name,
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: fontColor,
                      ),
                    ),
                  ),
                  Icon(Icons.location_on_outlined, size: 16, color: fontColor),
                  SizedBox(width: 4),
                  AutoSizeText("3.6 km", style: TextStyle(color: fontColor)),
                  SizedBox(width: 10),
                  Icon(Icons.timer_outlined, size: 16, color: fontColor),
                  SizedBox(width: 4),
                  AutoSizeText("10 min", style: TextStyle(color: fontColor)),
                ],
              ),

              Row(
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
              ),

              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: AutoSizeText(
                      "Burger King, Béjaïa, Algérie",
                      maxLines: 1,
                      minFontSize: 10,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: fontColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8), // Add a small gap between the two
                  Expanded(
                    flex: 1,
                    child: AutoSizeText(
                      "Q229+V73, Béjaïa, Algérie",
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
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: fontColor),
                      SizedBox(width: 4),
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
                    '${order.delPrice.toStringAsFixed(0)} DZD',
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

              const Divider(),

              AutoSizeText(
                " x ${order.products.first.quantity} ${order.products.first.name}",
                maxLines: 1,
                style: TextStyle(color: fontColor),
              ),
              AutoSizeText(
                " x ${order.products[1].quantity} ${order.products[1].name}",
                maxLines: 1,
                style: TextStyle(color: fontColor),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    size: 30,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          insetPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 60,
                          ),
                          child: OrderDetailsModal(order: order),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
