import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';
import 'package:mobileapp/features/customer/orders/business/entities/order_entity.dart';

class OrderCard extends ConsumerWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    final isDelivered = order.status == 4;
    final reduction =
        order.priceWithReduc == null || order.priceWithReduc == 0
            ? 0
            : order.totalAmount - (order.priceWithReduc ?? 0);
    final livraison = order.deliveryPrice;
    final totalNet = order.totalAmount + livraison - reduction;
    return Card(
      color: isDarkMode ? kSecondaryDark : kPrimaryWhite,
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant header + status/date + rating
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage("${order.business.imgUrl}"),
                  radius: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.business.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isDarkMode ? kSecondaryWhite : kSecondaryDark,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            isDelivered
                                ? "Livré"
                                : order.status == 0
                                ? "En attente"
                                : "En route",
                            style: TextStyle(
                              color:
                                  isDelivered ? kPrimaryGreen : Colors.orange,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "${order.createdAt.day.toString().padLeft(2, '0')}/${order.createdAt.month.toString().padLeft(2, '0')}/${order.createdAt.year} à ${order.createdAt.hour.toString().padLeft(2, '0')}:${order.createdAt.minute.toString().padLeft(2, '0')}",
                            style: TextStyle(
                              fontSize: 12,
                              color:
                                  isDarkMode ? kPrimaryWhite : kSecondaryDark,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (order.status == 4)
                  Row(
                    children: [
                      order.ratingBusns == 0 || order.ratingBusns == null
                          ? const Icon(Icons.star_border)
                          : const Icon(Icons.star, color: Colors.amber),
                      order.ratingBusns == 0 || order.ratingBusns == null
                          ? Text("")
                          : Text(
                            "${order.ratingBusns ?? ""}",
                            style: TextStyle(
                              color:
                                  isDarkMode ? kSecondaryWhite : kSecondaryDark,
                            ),
                          ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 8),
            // Deliverer info
            order.status == 0
                ? Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: kPrimaryRed,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "En attente d'un livreur...",
                        style: TextStyle(
                          color: isDarkMode ? kSecondaryWhite : kSecondaryDark,
                        ),
                      ),
                    ],
                  ),
                )
                : Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.delivery_dining,
                        size: 20,
                        color: kPrimaryRed,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${order.deliverer!.firstName} ${order.deliverer!.lastName}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color:
                                    isDarkMode
                                        ? kSecondaryWhite
                                        : kSecondaryDark,
                              ),
                            ),
                            Text(
                              order.deliverer!.phoneNumber,
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                    isDarkMode
                                        ? kSecondaryWhite
                                        : kSecondaryDark,
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (order.status == 4)
                        Row(
                          children: [
                            order.ratingDel == 0 || order.ratingDel == null
                                ? const Icon(Icons.star_border)
                                : const Icon(Icons.star, color: Colors.amber),
                            order.ratingDel == 0 || order.ratingDel == null
                                ? Text("")
                                : Text(
                                  "${order.ratingDel ?? ""}",
                                  style: TextStyle(
                                    color:
                                        isDarkMode
                                            ? kSecondaryWhite
                                            : kSecondaryDark,
                                  ),
                                ),
                          ],
                        ),
                    ],
                  ),
                ),

            const Divider(height: 20),
            // Product list
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  order.products.map((p) {
                    return Row(
                      children: [
                        Text(
                          "x${p.quantity}",
                          style: TextStyle(
                            color:
                                isDarkMode ? kSecondaryWhite : kSecondaryDark,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            p.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color:
                                  isDarkMode ? kSecondaryWhite : kSecondaryDark,
                            ),
                          ),
                        ),
                        Text(
                          "${p.price.toStringAsFixed(2)} DZD",
                          style: TextStyle(
                            color:
                                isDarkMode ? kSecondaryWhite : kSecondaryDark,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
            ),
            const SizedBox(height: 8),
            // Total
            Text(
              "${totalNet.toStringAsFixed(2)} DZD",
              style: const TextStyle(
                color: kPrimaryRed,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
