import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/deliverer/orders/presentation/widgets/client_section.dart';
import 'package:mobileapp/features/deliverer/orders/presentation/widgets/row_counter.dart';

class AtBusinessCard extends ConsumerWidget {
  final VoidCallback onNext;
  AtBusinessCard({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final fontColor = isDarkMode ? kWhiteGray : kDarkGray;
    final backgroundColor = isDarkMode ? kPrimaryDark : kPrimaryWhite;
    return Container(
      width: width * 0.85,
      height: height * 0.7,
      child: Card(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
          child: Column(
            children: [
              Text(
                'CMD N° - 62361 ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: fontColor,
                ),
              ),
              SizedBox(height: height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RowCounter.buildStepCircle(number: '1'),

                  RowCounter.buildConnector(width, height),

                  RowCounter.buildStepCircle(number: '2', isActive: true),

                  RowCounter.buildConnector(width, height),

                  RowCounter.buildStepCircle(number: '3'),

                  RowCounter.buildConnector(width, height),

                  RowCounter.buildStepCircle(number: '4'),
                ],
              ),
              SizedBox(height: height * 0.01),
              Text(
                'Récupérez les produits !',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryRed,
                ),
              ),
              _buildProductsList(height, fontColor),
              SizedBox(height: height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Montant total : ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: fontColor,
                    ),
                  ),
                  Text(
                    '3000 DZD',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryRed,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.05),
              ClientSection(),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryDark,
                      ),
                      onPressed: () {},
                      child: const AutoSizeText(
                        "Annuler",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryWhite,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryRed,
                      ),
                      onPressed: onNext,
                      child: const AutoSizeText(
                        "J’ai récupéré",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductsList(double screenHeight, Color fontColor) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Produits",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: fontColor,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            constraints: BoxConstraints(maxHeight: screenHeight * 0.14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Scrollbar(
              thickness: 8,
              thumbVisibility: true,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildProductText("Burger Cheese", 1, fontColor),
                    _buildProductText("Fries Large", 2, fontColor),
                    _buildProductText("Coke 500ml", 1, fontColor),
                    _buildProductText("Nuggets", 1, fontColor),
                    _buildProductText("Ice Cream", 1, fontColor),
                    _buildProductText("Nuggets", 1, fontColor),
                    _buildProductText("Ice Cream", 1, fontColor),
                    _buildProductText("Nuggets", 1, fontColor),
                    _buildProductText("Ice Cream", 1, fontColor),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductText(String productName, int quantity, Color fontColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
      child: Text(
        "x$quantity  $productName",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: fontColor,
        ),
      ),
    );
  }
}
