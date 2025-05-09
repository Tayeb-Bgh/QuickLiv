import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/orders/business/entities/order_entity.dart';

class OrderDetailsPage extends StatelessWidget {
  final Order order;

  const OrderDetailsPage({super.key, required this.order});

  String getStatusLabel(int status) {
    switch (status) {
      case 0:
        return "En attente";
      case 1:
        return "En route";
      case 2:
        return "En route";
      case 3:
        return "En route";
      default:
        return "";
    }
  }

  String getDeliveryStatusText(int status) {
    switch (status) {
      case 0:
        return "En attente d'un livreur";
      case 1:
        return "Le livreur est en route vers le commerce";
      case 2:
        return "Le livreur récupère les produits";
      case 3:
        return "Le livreur est en route vers vous";
      default:
        return "";
    }
  }

  Widget _buildProgressTracker(int status) {
    if (status == 0) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: kPrimaryRed,
              shape: BoxShape.circle,
              border: Border.all(color: kPrimaryWhite, width: 2),
            ),
          ),
          Expanded(child: Container(height: 2, color: Colors.black)),
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: kPrimaryRed,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.store, color: kPrimaryWhite, size: 12),
          ),
          Expanded(child: Container(height: 2, color: Colors.black)),
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: kPrimaryRed,
              shape: BoxShape.circle,
              border: Border.all(color: kPrimaryWhite, width: 2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInfo() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            "Position actuel",
            style: TextStyle(fontSize: 10),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          child: Text(
            "Burger King, Algérie",
            style: TextStyle(fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Text(
            "QZDQV73, Béjaïa, Algérie",
            style: TextStyle(fontSize: 10),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryInfo() {
    if (order.status == 0) {
      return Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                strokeWidth: 3,
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Livreur en attente",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  "Veuillez attendre qu'un livreur prenne votre commande",
                  style: TextStyle(
                    color: kMediumGray,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
    return Column(
      children: [
        _buildProgressTracker(order.status),
        if (order.status >= 1) _buildLocationInfo(),
        const SizedBox(height: 16),
        Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey.shade300,
              backgroundImage:
                  order.deliverer?.imgUrl != null
                      ? NetworkImage(order.deliverer!.imgUrl!)
                      : null,
              child:
                  order.deliverer?.imgUrl == null
                      ? const Icon(Icons.person, color: Colors.grey)
                      : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${order.deliverer?.firstName ?? ''} ${order.deliverer?.lastName ?? ''}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(order.deliverer?.phoneNumber ?? ''),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text("Arrivée estimée", style: TextStyle(fontSize: 12)),
                  Text(
                    "13h35 - 13h45",
                    style: TextStyle(fontSize: 12, color: kPrimaryRed),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProducts() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
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
                    color: index.isEven ? Colors.white : Colors.grey[50],
                    border: Border(
                      bottom: BorderSide(
                        color:
                            index == order.products.length - 1
                                ? Colors.transparent
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
                              style: TextStyle(
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
                                ),
                              ),
                              if (p.notice.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    p.notice,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "${p.price.toStringAsFixed(2)} DZD",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
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

  Widget _buildPaymentDetails() {
    final totalProduits = order.products.fold<double>(
      0,
      (sum, p) => sum + (p.price * p.quantity),
    );
    final reduction = 400.00; // Exemple, à ajuster selon vos besoins
    final livraison = order.deliveryPrice;
    final totalNet = order.totalAmount;

    return Column(
      children: [
        _buildDetailRow(
          "Total produits",
          "${totalProduits.toStringAsFixed(2)} DZD",
          bold: true,
        ),
        _buildDetailRow("Livraison", "${livraison.toStringAsFixed(2)} DZD"),
        _buildDetailRow(
          "Réduction",
          "-${reduction.toStringAsFixed(2)} DZD",
          color: Colors.green,
        ),
        const Divider(),
        _buildDetailRow(
          "Total net",
          "${totalNet.toStringAsFixed(2)} DZD",
          bold: true,
          color: kPrimaryRed,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text("Moyen de paiement"),
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
                      ? Icon(Icons.credit_card, size: 16)
                      : Icon(Icons.money, size: 16),
                  SizedBox(width: 4),
                  order.paymentMethod ? Text("Carte") : Text("Cash"),
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
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: bold ? FontWeight.bold : null),
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: bold ? FontWeight.bold : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancelNote() {
    if (order.status == 0) {
      return Container(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryRed,
            padding: EdgeInsets.symmetric(vertical: 12),
          ),
          onPressed: () {
            // Annulation possible
          },
          child: Text(
            "Annuler",
            style: TextStyle(color: kPrimaryWhite, fontSize: 16),
          ),
        ),
      );
    } else if (order.status == 1) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "La livraison est déjà en route, si vous voulez annuler votre commande, en cliquant sur le bouton annuler en bas, vous appellerez automatiquement votre livreur afin de vous arranger avec lui.",
              style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
            ),
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryRed,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                // Annulation possible
              },
              child: Text(
                "Annuler",
                style: TextStyle(color: kPrimaryWhite, fontSize: 16),
              ),
            ),
          ),
        ],
      );
    } else {
      return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
            children: [
              TextSpan(
                text:
                    "La livraison est déjà en route, et il est deja arrivé au commerce correspondant vous ne pouvez plus ",
              ),
              TextSpan(text: "annuler", style: TextStyle(color: kPrimaryRed)),
              TextSpan(text: " votre commande."),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      children: [
        Center(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(color: Colors.grey[50]),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
                Container(
                  height: 6,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: kMediumGray,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final date = DateFormat("dd/MM/yyyy à HH:mm").format(order.createdAt);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Détails de la commande",
          style: TextStyle(color: kPrimaryWhite),
        ),
        backgroundColor: kPrimaryRed,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kPrimaryWhite),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
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
                        ),
                      ),
                      Text(
                        "${getStatusLabel(order.status)}",
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(date, style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            _buildSectionTitle("Livraison"),
            Padding(
              padding: const EdgeInsets.only(bottom: 3, left: 18, right: 18),
              child: Column(
                children: [
                  Text(
                    getDeliveryStatusText(order.status),
                    style: TextStyle(
                      color: kPrimaryRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildDeliveryInfo(),
                ],
              ),
            ),
            _buildSectionTitle("Produits commandés"),
            Padding(padding: const EdgeInsets.all(16), child: _buildProducts()),
            _buildSectionTitle("Détails de paiement"),
            Padding(
              padding: const EdgeInsets.all(16),
              child: _buildPaymentDetails(),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: _buildCancelNote(),
            ),
          ],
        ),
      ),
    );
  }
}
