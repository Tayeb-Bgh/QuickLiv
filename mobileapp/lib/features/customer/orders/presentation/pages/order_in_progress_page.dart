import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/auth/presentation/providers/auth_provider.dart';
import 'package:mobileapp/features/customer/orders/business/entities/order_entity.dart';
import 'package:mobileapp/features/customer/orders/presentation/pages/sockets.dart';
import 'package:mobileapp/features/customer/orders/presentation/providers/orders_provider.dart';
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
      log("LISTENING FOOOR");
      _currentOrder.status = data['status'];
      if (data['status'] != 4) {
        if (mounted) {
          setState(() {});
        }
      } else {
        if (mounted) {
          setState(() {
            showRatingDialog(context);
          });
        }
      }
    });
  }

  Future<bool> insertCart(Map<String, dynamic> orderData, int orderId) async {
    final baseUrl = await ApiConfig.getBaseUrl();
    final url = "$baseUrl/orders/customer-orders/$orderId/rate";
    log("at URL $url");
    try {
      final secureStorage = ref.watch(secureStorageProvider);
      Dio dio = Dio();
      String? token = await secureStorage.read(key: "authToken");

      final response = await dio.put(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $token',
          },
        ),
        data: orderData,
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        throw Error();
      }
    } catch (e) {
      rethrow;
    }
  }

  Widget _buildIconButton(
    IconData icon,
    Color bgColor,
    VoidCallback onPressed,
  ) {
    return IconButton(
      icon: Icon(icon, color: Colors.white),
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(bgColor),
        shape: WidgetStateProperty.all(const CircleBorder()),
        padding: WidgetStateProperty.all(const EdgeInsets.all(12)),
      ),
    );
  }

  void showRatingDialog(BuildContext context) {
    double ratingDel = 0;
    double ratingBusns = 0;
    bool showThankYou = true;

    showGeneralDialog(
      context: context,
      barrierLabel: "Rating",
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) => const SizedBox(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Transform.scale(
              scale: Curves.easeOutBack.transform(animation.value),
              child: Opacity(
                opacity: animation.value,
                child: AlertDialog(
                  backgroundColor:
                      ref.watch(darkModeProvider)
                          ? kPrimaryDark
                          : kSecondaryWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child:
                        showThankYou
                            ? Text(
                              key: ValueKey("thankyou-title"),
                              "Merci pour votre commande !",
                              style: TextStyle(
                                color:
                                    ref.watch(darkModeProvider)
                                        ? kSecondaryWhite
                                        : kPrimaryBlack,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )
                            : Column(
                              key: const ValueKey("rating-title"),
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Comment a été votre expérience ?",
                                  style: TextStyle(
                                    color:
                                        ref.watch(darkModeProvider)
                                            ? kWhiteGray
                                            : kSecondaryDark,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Merci de prendre un moment pour nous donner votre avis.",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        ref.watch(darkModeProvider)
                                            ? kWhiteGray
                                            : kSecondaryDark,
                                  ),
                                ),
                              ],
                            ),
                  ),
                  content: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child:
                        showThankYou
                            ? Text(
                              key: ValueKey("thankyou-content"),
                              "Nous espérons que tout s'est bien passé. Appuyez sur 'Suivant' pour évaluer votre expérience.",
                              style: TextStyle(
                                fontSize: 15,
                                color:
                                    ref.watch(darkModeProvider)
                                        ? kWhiteGray
                                        : kSecondaryDark,
                              ),
                            )
                            : Column(
                              key: const ValueKey("rating-content"),
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Divider(thickness: 1.2),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.delivery_dining,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "Noter le livreur",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            ref.watch(darkModeProvider)
                                                ? kWhiteGray
                                                : kSecondaryDark,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                RatingBar.builder(
                                  initialRating: ratingDel,
                                  minRating: 1,
                                  unratedColor:
                                      ref.watch(darkModeProvider)
                                          ? kMediumGray
                                          : kLightGray,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  itemSize: 36,
                                  itemPadding: const EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                  ),
                                  itemBuilder:
                                      (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                  onRatingUpdate: (newRating) {
                                    ratingDel = newRating;
                                  },
                                ),
                                const SizedBox(height: 24),
                                Row(
                                  children: [
                                    Icon(Icons.store, color: Colors.blue),
                                    SizedBox(width: 8),
                                    Text(
                                      "Noter le commerce",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            ref.watch(darkModeProvider)
                                                ? kWhiteGray
                                                : kSecondaryDark,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                RatingBar.builder(
                                  initialRating: ratingBusns,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  unratedColor:
                                      ref.watch(darkModeProvider)
                                          ? kMediumGray
                                          : kLightGray,
                                  itemSize: 36,
                                  itemPadding: const EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                  ),
                                  itemBuilder:
                                      (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                  onRatingUpdate: (newRating) {
                                    ratingBusns = newRating;
                                  },
                                ),
                              ],
                            ),
                  ),
                  actionsPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actions: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child:
                          showThankYou
                              ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  _buildIconButton(
                                    Icons.arrow_forward,
                                    kPrimaryRed,
                                    () {
                                      setState(() {
                                        showThankYou = false;
                                      });
                                    },
                                  ),
                                ],
                              )
                              : Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  _buildIconButton(
                                    Icons.check,
                                    kPrimaryRed,
                                    () {
                                      final data = {
                                        "rateDel":
                                            ratingDel != 0
                                                ? ratingDel.round()
                                                : null,
                                        "rateBusns":
                                            ratingBusns != 0
                                                ? ratingBusns.round()
                                                : null,
                                      };

                                      insertCart(data, widget.order.id);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
                      _currentOrder.business.name,
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

  Widget _buildDeliveryInfo(WidgetRef ref, int status) {
    final isDarkMode = ref.watch(darkModeProvider);
    if (status == 0) {
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
        _buildProgressTracker(status),
        if (status >= 1) _buildLocationInfo(status),
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

  Future<bool> deleteOrder(int orderId) async {
    final baseUrl = await ApiConfig.getBaseUrl();
    final url = "$baseUrl/orders/customer-orders/$orderId";
    log("at URL $url");
    try {
      final secureStorage = ref.watch(secureStorageProvider);
      Dio dio = Dio();
      String? token = await secureStorage.read(key: "authToken");

      final response = await dio.delete(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        throw Error();
      }
    } catch (e) {
      rethrow;
    }
  }

  void showDeleteConfirmationDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "DeleteConfirmation",
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) => const SizedBox(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return Transform.scale(
          scale: Curves.easeOutBack.transform(animation.value),
          child: Opacity(
            opacity: animation.value,
            child: AlertDialog(
              backgroundColor:
                  ref.watch(darkModeProvider) ? kPrimaryDark : kSecondaryWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(
                "Êtes-vous sûr ?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color:
                      ref.watch(darkModeProvider)
                          ? kSecondaryWhite
                          : kPrimaryBlack,
                ),
              ),
              content: Text(
                "Voulez-vous vraiment supprimer cette commande ? Cette action est irréversible.",
                style: TextStyle(
                  fontSize: 15,
                  color:
                      ref.watch(darkModeProvider) ? kWhiteGray : kSecondaryDark,
                ),
              ),
              actionsPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actions: [
                _buildIconButton(Icons.close, kPrimaryBlack, () {
                  Navigator.pop(context);
                }),
                _buildIconButton(Icons.check, kPrimaryRed, () {
                  deleteOrder(widget.order.id);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  ref.invalidate(customerFullOrdersProvider);
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCancelNote(int status) {
    if (status == 0) {
      return Container(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryRed,
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          onPressed: () {
            showDeleteConfirmationDialog(context);
          },
          child: const Text(
            "Annuler",
            style: TextStyle(color: kPrimaryWhite, fontSize: 16),
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
                    "La livraison est déjà en route, le livreur est en route avec les produits commandés. Vous ne pouvez plus ",
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

  Widget _buildSectionTitle(String title, WidgetRef ref, int status) {
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
    log("IN PROGRESS DISPOSE");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(darkModeProvider);
    final date = DateFormat(
      "dd/MM/yyyy à HH:mm",
    ).format(_currentOrder.createdAt);

    //final int status = ref.watch(currentOrderProvider)!.status;
    log("rebuildiiiiiiiiiiing");
    //log("STATUS IN THE WIDGET $status");
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
              _buildSectionTitle("Livraison", ref, _currentOrder.status),
              Padding(
                padding: const EdgeInsets.only(bottom: 3, left: 18, right: 18),
                child: _buildDeliveryInfo(ref, _currentOrder.status),
              ),
              _buildSectionTitle(
                "Produits commandés",
                ref,
                _currentOrder.status,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: _buildProducts(ref),
              ),
              _buildSectionTitle(
                "Détails de paiement",
                ref,
                _currentOrder.status,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: _buildPaymentDetails(ref),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: _buildCancelNote(_currentOrder.status),
              ),
              SizedBox(height: 20), // Espace supplémentaire en bas
            ],
          ),
        ),
      ),
    );
  }
}
