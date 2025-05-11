import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/deliverer/orders/presentation/widgets/client_section.dart';
import 'package:mobileapp/features/deliverer/orders/presentation/widgets/map_section.dart';
import 'package:mobileapp/features/deliverer/orders/presentation/widgets/row_counter.dart';

class BusinessRendezvousCard extends ConsumerWidget {
  final VoidCallback onNext;

  const BusinessRendezvousCard({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isDarkMode = ref.watch(darkModeProvider);
    final backgroundColor = isDarkMode ? kPrimaryDark : kPrimaryWhite;
    final fontColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    log('$isDarkMode');
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
                'CMD N° - 62315 ',
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
                  RowCounter.buildStepCircle(number: '1', isActive: true),

                  RowCounter.buildConnector(width, height),

                  RowCounter.buildStepCircle(number: '2'),

                  RowCounter.buildConnector(width, height),

                  RowCounter.buildStepCircle(number: '3'),

                  RowCounter.buildConnector(width, height),

                  RowCounter.buildStepCircle(number: '4'),
                ],
              ),
              SizedBox(height: height * 0.01),

              SizedBox(height: height * 0.01),
              _buildBusinessRow(
                businessName: 'Burger King',
                imageUrl:
                    'https://media.timeout.com/images/106194093/1920/1440/image.webp',
                phoneNumber: '0551236050',
                context: context,
                fontColor: fontColor,
              ),
              SizedBox(height: height * 0.01),
              MapSection(),
              SizedBox(height: height * 0.01),
              ClientSection(),
              SizedBox(height: height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryDark,
                    ),
                    onPressed: () {},
                    child: AutoSizeText(
                      "Annuler",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryWhite
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryRed,
                    ),
                    onPressed: onNext,
                    child: const AutoSizeText(
                      "Je suis arrivé ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBusinessRow({
    required String imageUrl,
    required String businessName,
    required String phoneNumber,
    required Color fontColor,
    required context,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(radius: 30, backgroundImage: NetworkImage(imageUrl)),
        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                businessName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: fontColor,
                ),
              ),
              const SizedBox(height: 5),

              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: fontColor,
                        style: BorderStyle.solid,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.phone, size: 16, color: fontColor),
                        const SizedBox(width: 5),
                        Text(
                          phoneNumber,
                          style: TextStyle(fontSize: 14, color: fontColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: phoneNumber));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Phone number copied to clipboard'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Icon(Icons.copy, size: 20, color: fontColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
