import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/orders/business/entities/order_entity.dart';
import 'package:mobileapp/features/customer/orders/presentation/pages/sockets.dart';
import 'package:mobileapp/features/customer/orders/presentation/widgets/animated_progress.dart';

class OrderDetailsPage extends ConsumerStatefulWidget {
  final Order order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  ConsumerState<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends ConsumerState<OrderDetailsPage> {
  late Order _currentOrder;
  final SocketService _socketService = SocketService();

  @override
  void initState() {
    super.initState();
    _currentOrder = widget.order;
    _setupSocketConnection();
  }

  void _setupSocketConnection() {
    _socketService.connect();
    _socketService.joinOrderRoom(_currentOrder.id.toString());

    _socketService.listenForOrderUpdates((data) {
      log("la je peut reload ${data['status']}");
      if (mounted && data['commandeId'] == _currentOrder.id) {
        setState(() {
          _currentOrder = _currentOrder.copyWithStatus(data['status']);
        });
      }
    });
  }

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
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(
            height: 50, // Hauteur explicite pour que Stack puisse se mesurer
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Ligne de base
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: kPrimaryRed,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.my_location, color: kPrimaryWhite),
                    ),
                    Expanded(
                      child: Container(
                        height: 2,
                        color: status >= 1 ? kPrimaryRed : kPrimaryWhite,
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: status >= 2 ? kPrimaryRed : Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.store,
                        color: status == 1 ? kMediumGray : kPrimaryWhite,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 2,
                        color: status >= 3 ? kPrimaryRed : Colors.grey[300],
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: status > 3 ? kPrimaryRed : Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.location_on,
                        color: status <= 3 ? kMediumGray : kPrimaryWhite,
                      ),
                    ),
                  ],
                ),

                // Animations selon le statut
                if (status == 1)
                  Positioned.fill(
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Stack(
                            children: [MovingDot(color: kPrimaryRed, size: 0)],
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Expanded(child: SizedBox()),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),

                /* if (status == 2)
                  Positioned(
                    left: 169,
                    top:
                        12, // pour l'aligner verticalement au centre approximatif
                    child: SizedBox(
                      width: 36,
                      height: 36,
                      child: PulsatingCircle(
                        color: Color(
                          0x1AFF0000,
                        ), // kPrimaryRed avec .withOpacity(0.1)
                        size: 56,
                        child: Icon(
                          Icons.shopping_bag,
                          color: kPrimaryRed,
                          size: 0,
                        ),
                      ),
                    ),
                  ),
 */
                /* if (status == 3)
                  Positioned.fill(
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        const Expanded(child: SizedBox()),
                        const SizedBox(width: 20),
                        const Expanded(
                          child: Stack(
                            children: [
                              MovingDot(
                                color: kPrimaryRed,
                                size: 8,
                                reverse: false,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
               */
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInfo(int status) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Position du livreur",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: status == 1 ? kPrimaryRed : Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Burger King, Algérie",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color:
                            status == 2 || status == 3
                                ? kPrimaryRed
                                : Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Votre position  ",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: status > 3 ? kPrimaryRed : Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          if (status == 1)
            Text(
              "Le livreur est en route vers le restaurant",
              style: TextStyle(
                color: kPrimaryRed,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          if (status == 2)
            Text(
              "Le livreur récupère votre commande",
              style: TextStyle(
                color: kPrimaryRed,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          if (status == 3)
            Text(
              "Le livreur est en route vers vous",
              style: TextStyle(
                color: kPrimaryRed,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }

  Widget _buildDeliveryInfo(WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    if (_currentOrder.status == 0) {
      return Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: kMediumGray,
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
                Text(
                  "Livreur en attente",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: isDarkMode ? kSecondaryWhite : kSecondaryDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Veuillez attendre qu'un livreur prenne votre commande",
                  style: TextStyle(
                    color: isDarkMode ? kRegularGray : kMediumGray,
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
        _buildProgressTracker(_currentOrder.status),
        if (_currentOrder.status >= 1) _buildLocationInfo(_currentOrder.status),
        const SizedBox(height: 16),
        Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey.shade300,
              backgroundImage:
                  _currentOrder.deliverer?.imgUrl != null
                      ? NetworkImage(_currentOrder.deliverer!.imgUrl!)
                      : null,
              child:
                  _currentOrder.deliverer?.imgUrl == null
                      ? const Icon(Icons.person, color: Colors.grey)
                      : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${_currentOrder.deliverer?.firstName ?? ''} ${_currentOrder.deliverer?.lastName ?? ''}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? kSecondaryWhite : kSecondaryDark,
                    ),
                  ),
                  Text(
                    _currentOrder.deliverer?.phoneNumber ?? '',
                    style: TextStyle(
                      color: isDarkMode ? kSecondaryWhite : kSecondaryDark,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isDarkMode ? kSecondaryDark : kLightGrayWhite,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    "Arrivée estimée",
                    style: TextStyle(
                      fontSize: 12,
                      color: isDarkMode ? kSecondaryWhite : kPrimaryBlack,
                    ),
                  ),
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
              _currentOrder.products.asMap().entries.map((entry) {
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
                            index == _currentOrder.products.length - 1
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
    final totalProduits = _currentOrder.products.fold<double>(
      0,
      (sum, p) => sum + (p.price * p.quantity),
    );
    final reduction =
        _currentOrder.priceWithReduc == null ||
                _currentOrder.priceWithReduc == 0
            ? 0
            : _currentOrder.totalAmount - (_currentOrder.priceWithReduc ?? 0);
    final livraison = _currentOrder.deliveryPrice;
    final totalNet = _currentOrder.totalAmount + livraison - reduction;

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
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  _currentOrder.paymentMethod
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
                  const SizedBox(width: 4),
                  _currentOrder.paymentMethod
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
              color: color,
              fontWeight: bold ? FontWeight.bold : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancelNote() {
    if (_currentOrder.status == 0) {
      return Container(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryRed,
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          onPressed: () {
            // Annulation possible
          },
          child: const Text(
            "Annuler",
            style: TextStyle(color: kPrimaryWhite, fontSize: 16),
          ),
        ),
      );
    } else if (_currentOrder.status == 1) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "La livraison est déjà en route, si vous voulez annuler votre commande, en cliquant sur le bouton annuler en bas, vous appellerez automatiquement votre livreur afin de vous arranger avec lui.",
              style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryRed,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                // Annulation possible
              },
              child: const Text(
                "Annuler",
                style: TextStyle(color: kPrimaryWhite, fontSize: 16),
              ),
            ),
          ),
        ],
      );
    } else if (_currentOrder.status == 2) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
            children: [
              const TextSpan(
                text:
                    "La livraison est déjà en route, et il est deja arrivé au commerce correspondant vous ne pouvez plus ",
              ),
              TextSpan(
                text: "annuler",
                style: const TextStyle(color: kPrimaryRed),
              ),
              const TextSpan(text: " votre commande."),
            ],
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
            children: [
              const TextSpan(
                text:
                    "La livraison est déjà en route, le livreur est en route vers vous avec les produits commander. Vous ne pouvez plus ",
              ),
              TextSpan(
                text: "annuler",
                style: const TextStyle(color: kPrimaryRed),
              ),
              const TextSpan(text: " votre commande."),
            ],
          ),
        ),
      );
    }
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

  @override
  void dispose() {
    _socketService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(darkModeProvider);
    final date = DateFormat(
      "dd/MM/yyyy à HH:mm",
    ).format(_currentOrder.createdAt);

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
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
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
                      backgroundImage: NetworkImage(
                        _currentOrder.business.imgUrl,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _currentOrder.business.name,
                            maxLines: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color:
                                  isDarkMode ? kSecondaryWhite : kSecondaryDark,
                            ),
                          ),
                          Text(
                            getStatusLabel(_currentOrder.status),
                            style: const TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                    AutoSizeText(
                      date,
                      style: TextStyle(
                        color: isDarkMode ? kSecondaryWhite : kMediumGray,
                      ),
                      minFontSize: 6,
                    ),
                  ],
                ),
              ),
              _buildSectionTitle("Livraison", ref),
              Padding(
                padding: const EdgeInsets.only(bottom: 3, left: 18, right: 18),
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
              Padding(
                padding: const EdgeInsets.all(16),
                child: _buildCancelNote(),
              ),
              SizedBox(height: 20), // Espace supplémentaire en bas
            ],
          ),
        ),
      ),
    );
  }
}
