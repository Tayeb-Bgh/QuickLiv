import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/hive_object/deliverer_hive_object.dart';

class DriverProfileCard extends StatelessWidget {
  final DelivererHiveObject? savedDeliverer;
  const DriverProfileCard({super.key, required this.savedDeliverer});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final firstName = savedDeliverer?.firstName ?? 'N/A';
    final lastName = savedDeliverer?.lastName ?? 'N/A';
    return Card(
      elevation: 4,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: kPrimaryRed,
              radius: height * 0.04,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: height * 0.04,
              ),
            ),
            SizedBox(width: width * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    " $firstName $lastName ",
                    maxLines: 1,
                    minFontSize: 16,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green[200]!),
                    ),
                    child: const AutoSizeText(
                      'En service',
                      maxLines: 1,
                      minFontSize: 10,
                      style: TextStyle(
                        fontSize: 12,
                        color: kPrimaryGreen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      AutoSizeText(
                         (savedDeliverer?.rating.toString() ?? 'N/A'),
                        maxLines: 1,
                        minFontSize: 12,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      AutoSizeText(
                        (savedDeliverer?.deliveryNbr.toString() ?? 'N/A'),
                        maxLines: 1,
                        minFontSize: 12,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
