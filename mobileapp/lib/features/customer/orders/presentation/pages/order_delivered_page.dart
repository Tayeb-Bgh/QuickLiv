import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/orders/business/entities/order_entity.dart';

class OrderDeliveredPage extends ConsumerWidget {
  final Order order;

  const OrderDeliveredPage({super.key, required this.order});

  Widget _buildProducts(WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.1 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              order.products.asMap().entries.map((entry) {
                final index = entry.key;
                final p = entry.value;

                return Container(
                  decoration: BoxDecoration(
                    color:
                        index.isEven
                            ? (isDarkMode ? kSecondaryDark : Colors.white)
                            : (isDarkMode ? kPrimaryDark : Colors.grey[50]),
                    border: Border(
                      bottom: BorderSide(
                        color:
                            index == order.products.length - 1
                                ? Colors.transparent
                                : isDarkMode
                                ? Colors.grey[800]!
                                : Colors.grey[200]!,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: kPrimaryRed.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(
                              "x${p.quantity}",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryRed,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                p.name,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      isDarkMode
                                          ? kSecondaryWhite
                                          : kSecondaryDark,
                                ),
                              ),
                              if (p.notice.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    p.notice,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          isDarkMode
                                              ? kRegularGray
                                              : Colors.grey[600],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isDarkMode ? kMediumGray : Colors.grey[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "${p.price.toStringAsFixed(2)} DZD",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color:
                                  isDarkMode ? kSecondaryWhite : Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildPaymentDetails(WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    final totalProduits = order.products.fold<double>(
      0,
      (sum, p) => sum + (p.price * p.quantity),
    );
    final reduction =
        order.priceWithReduc == null || order.priceWithReduc == 0
            ? 0
            : order.totalAmount - (order.priceWithReduc ?? 0);
    final livraison = order.deliveryPrice;
    final totalNet = order.totalAmount + order.deliveryPrice - reduction;

    return Column(
      children: [
        _buildDetailRow(
          "Total produits",
          "${totalProduits.toStringAsFixed(2)} DZD",
          bold: true,
          color: isDarkMode ? kSecondaryWhite : kSecondaryDark,
          ref: ref,
        ),
        _buildDetailRow(
          "Livraison",
          "${livraison.toStringAsFixed(2)} DZD",
          color: isDarkMode ? kSecondaryWhite : kSecondaryDark,
          ref: ref,
        ),
        _buildDetailRow(
          "Réduction",
          "-${reduction.toStringAsFixed(2)} DZD",
          color: Colors.green,
          ref: ref,
        ),
        const Divider(),
        _buildDetailRow(
          "Total net",
          "${totalNet.toStringAsFixed(2)} DZD",
          bold: true,
          color: kPrimaryRed,
          ref: ref,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text(
              "Moyen de paiement",
              style: TextStyle(
                color: isDarkMode ? kSecondaryWhite : kSecondaryDark,
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  order.paymentMethod
                      ? Icon(
                        Icons.credit_card,
                        size: 16,
                        color: isDarkMode ? kSecondaryWhite : kSecondaryDark,
                      )
                      : Icon(
                        Icons.money,
                        size: 16,
                        color: isDarkMode ? kSecondaryWhite : kSecondaryDark,
                      ),
                  SizedBox(width: 4),
                  order.paymentMethod
                      ? Text(
                        "Carte",
                        style: TextStyle(
                          color: isDarkMode ? kSecondaryWhite : kSecondaryDark,
                        ),
                      )
                      : Text(
                        "Cash",
                        style: TextStyle(
                          color: isDarkMode ? kSecondaryWhite : kSecondaryDark,
                        ),
                      ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    Color? color,
    bool bold = false,
    required WidgetRef ref,
  }) {
    final isDarkMode = ref.watch(darkModeProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : null,
              color: isDarkMode ? kSecondaryWhite : kPrimaryBlack,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: color ?? (isDarkMode ? kSecondaryWhite : kPrimaryBlack),
              fontWeight: bold ? FontWeight.bold : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    return Column(
      children: [
        Center(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: isDarkMode ? kPrimaryDark : kSecondaryWhite,
            ),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                    color: isDarkMode ? kSecondaryWhite : kMediumGray,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Container(
                  height: 6,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: isDarkMode ? kLightGray : kMediumGray,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPointsEarned() {
    final pointsEarned = (order.totalAmount / 20).round();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.confirmation_num, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Vous avez reçu +$pointsEarned points après avoir effectué cette commande !",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryInfo(WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[300],
            backgroundImage:
                order.deliverer?.imgUrl != null
                    ? NetworkImage(order.deliverer!.imgUrl!)
                    : null,
            child:
                order.deliverer?.imgUrl == null
                    ? Icon(
                      Icons.person,
                      color: isDarkMode ? Colors.grey[400] : Colors.grey,
                    )
                    : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${order.deliverer?.firstName ?? ''} ${order.deliverer?.lastName ?? ''}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? kSecondaryWhite : kSecondaryDark,
                  ),
                ),
                Text(
                  "Service rapide et efficace",
                  style: TextStyle(
                    color: isDarkMode ? kRegularGray : Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSection(WidgetRef ref) {
    return Column(
      children: [
        _buildSectionTitle("Notation", ref),
        const SizedBox(height: 12),
        _buildRatingItem("Livraison", order.ratingDel?.toDouble(), ref),
        const SizedBox(height: 8),
        _buildRatingItem("Commerce", order.ratingBusns?.toDouble(), ref),
      ],
    );
  }

  Widget _buildRatingItem(String title, double? rating, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
        ),
        borderRadius: BorderRadius.circular(8),
        color: isDarkMode ? kSecondaryDark : Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: isDarkMode ? kSecondaryWhite : kSecondaryDark,
            ),
          ),
          rating != null && rating > 0
              ? Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < rating.round() ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 23,
                  );
                }),
              )
              : GestureDetector(
                onTap: () {
                  // Laisser vide comme demandé
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: kPrimaryRed.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "Noter",
                    style: const TextStyle(
                      color: kPrimaryRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    final date = DateFormat("dd/MM/yyyy à HH:mm").format(order.createdAt);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Détails de la commande",
          style: TextStyle(color: kPrimaryWhite),
        ),
        backgroundColor: kPrimaryRed,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kPrimaryWhite),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: isDarkMode ? kPrimaryDark : kSecondaryWhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(order.business.imgUrl),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.business.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color:
                                isDarkMode ? kSecondaryWhite : kSecondaryDark,
                          ),
                        ),
                        const Text(
                          "Livré",
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDarkMode ? kSecondaryWhite : kMediumGray,
                      ),
                    ),
                  ],
                ),
              ),
              _buildPointsEarned(),
              _buildSectionTitle("Livraison", ref),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildDeliveryInfo(ref),
              ),
              _buildSectionTitle("Produits commandés", ref),
              Padding(
                padding: const EdgeInsets.all(16),
                child: _buildProducts(ref),
              ),
              _buildSectionTitle("Détails de paiement", ref),
              Padding(
                padding: const EdgeInsets.all(16),
                child: _buildPaymentDetails(ref),
              ),
              _buildRatingSection(ref),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
