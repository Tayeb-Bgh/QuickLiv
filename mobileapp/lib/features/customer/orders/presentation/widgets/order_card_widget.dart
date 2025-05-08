import 'package:flutter/material.dart';
import 'package:mobileapp/features/customer/orders/business/entities/order_entity.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final isDelivered = order.status == 4;

    return Card(
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
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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
                              color: isDelivered ? Colors.green : Colors.orange,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "${order.createdAt.day.toString().padLeft(2, '0')}/${order.createdAt.month.toString().padLeft(2, '0')}/${order.createdAt.year} à ${order.createdAt.hour.toString().padLeft(2, '0')}:${order.createdAt.minute.toString().padLeft(2, '0')}",
                            style: const TextStyle(fontSize: 12),
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
                          : Text("${order.ratingBusns ?? ""}"),
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
                    children: const [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: 8),
                      Text("En attente d'un livreur..."),
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
                        color: Colors.red,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${order.deliverer!.firstName} ${order.deliverer!.lastName}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              order.deliverer!.phoneNumber,
                              style: const TextStyle(fontSize: 12),
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
                                : Text("${order.ratingDel ?? ""}"),
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
                        Text("x${p.quantity}"),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            p.name,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text("${p.price} DZD"),
                      ],
                    );
                  }).toList(),
            ),
            const SizedBox(height: 8),
            // Total
            Text(
              "${order.totalAmount} DZD",
              style: const TextStyle(
                color: Colors.red,
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
