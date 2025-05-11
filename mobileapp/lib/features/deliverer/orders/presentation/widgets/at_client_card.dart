import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/deliverer/orders/presentation/widgets/client_section.dart';
import 'package:mobileapp/features/deliverer/orders/presentation/widgets/map_section.dart';
import 'package:mobileapp/features/deliverer/orders/presentation/widgets/payment_section.dart';
import 'package:mobileapp/features/deliverer/orders/presentation/widgets/row_counter.dart';

class AtClientCard extends ConsumerWidget {
  final VoidCallback reset;
  AtClientCard({super.key, required this.reset});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isDarkMode = ref.watch(darkModeProvider);
    final backgroundColor = isDarkMode ? kPrimaryDark : kPrimaryWhite;
    final fontColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;

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
                  color: fontColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RowCounter.buildStepCircle(number: '1'),

                  RowCounter.buildConnector(width, height),

                  RowCounter.buildStepCircle(number: '2'),

                  RowCounter.buildConnector(width, height),

                  RowCounter.buildStepCircle(number: '3'),

                  RowCounter.buildConnector(width, height),

                  RowCounter.buildStepCircle(number: '4', isActive: true),
                ],
              ),
              SizedBox(height: height * 0.01),
              Text(
                ' Livrez au client !',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryRed,
                ),
              ),
              SizedBox(height: height * 0.01),
              ClientSection(),
              SizedBox(height: height * 0.01),
              PaymentSection(),
              SizedBox(height: height * 0.01),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: kPrimaryRed),
                onPressed: reset,
                child: AutoSizeText(
                  "Finaliser la commande",
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
      ),
    );
  }
}
