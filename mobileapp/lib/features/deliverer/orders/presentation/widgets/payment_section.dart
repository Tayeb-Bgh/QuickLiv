import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/deliverer/orders/business/entities/order_entity.dart';

class PaymentSection extends ConsumerWidget {
  final OrderEntity order;
  const PaymentSection({super.key, required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isDarkMode = ref.watch(darkModeProvider);

    final fontColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    return Column(
      spacing: 5,
      children: [
        Text(
          'Informations sur le paiement',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? kLightGray : kDarkGray,
          ),
        ),
        SizedBox(height: height * 0.006),
        Divider(
          color: isDarkMode ? kLightGray : kDarkGray,
          thickness: 3.5,
          height: 0,
        ),
        SizedBox(height: height * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Produits',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: fontColor,
              ),
            ),
            Text(
              '${(order.totalPrice - order.delPrice).toStringAsFixed(0)}. DZD',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: fontColor,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Livraison',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: fontColor,
              ),
            ),
            Text(
              '${order.delPrice.toStringAsFixed(0)} DZD',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: fontColor,
              ),
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total net',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: fontColor,
              ),
            ),
            Text(
              '${order.totalPrice.toStringAsFixed(0)} DZD',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kPrimaryRed,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Moyenne de payment',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: fontColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                border: Border.all(color: fontColor, width: 2),
              ),
              child:
                  order.payMethod
                      ? Row(
                        children: [
                          Icon(Icons.credit_card, size: 16, color: fontColor),
                          Text(
                            'Carte',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: fontColor,
                            ),
                          ),
                        ],
                      )
                      : Row(
                        children: [
                          Icon(
                            Icons.monetization_on,
                            size: 16,
                            color: fontColor,
                          ),
                          Text(
                            'especes',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: fontColor,
                            ),
                          ),
                        ],
                      ),
            ),
          ],
        ),
        SizedBox(height: height * 0.02),
        order.payMethod
            ? _customerPayed(fontColor)
            : _customerNotPayed(fontColor),
        SizedBox(height: height * 0.02),
      ],
    );
  }

  _customerPayed(Color fontColor) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: kPrimaryGreen, // or any color you prefer
          width: 2.0, // optional, default is 1.0
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, size: 40, color: kPrimaryGreen),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      'Le client a payé par carte !',
                      style: TextStyle(
                        fontSize: 16,
                        color: kPrimaryGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    AutoSizeText(
                      'Vous n’avez donc pas besoin d’encaisser l’argent le client a déjà payé par carte.',
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      style: TextStyle(
                        color: fontColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _customerNotPayed(Color fontColor) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: kPrimaryRed, // or any color you prefer
          width: 2.0, // optional, default is 1.0
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, size: 40, color: kPrimaryRed),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      'Le client n’a pas payé !',
                      style: TextStyle(
                        fontSize: 20,
                        color: kPrimaryRed,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    AutoSizeText(
                      'Vous devez encaisser l’argent avant de finaliser la commande',
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      style: TextStyle(
                        color: fontColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
