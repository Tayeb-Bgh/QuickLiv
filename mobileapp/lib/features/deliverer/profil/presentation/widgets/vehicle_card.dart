import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/hive_object/vehicle_hive_object.dart';
import 'package:intl/intl.dart';

class VehicleInfoCard extends ConsumerWidget {
  const VehicleInfoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isDarkMode = ref.watch(darkModeProvider);
    var vehicleBox = Hive.box<VehicleHiveObject>('vehicleBox');
    VehicleHiveObject? savedVehicle = vehicleBox.get('currentVehicle');

    final textColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    final cardColor = isDarkMode ? kSecondaryDark : kPrimaryWhite;
    final accentColor = kPrimaryRed;
    final subtitleColor = isDarkMode ? kLightGray : kDarkGray;
    final iconColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;

    return Center(
      child: Container(
        constraints: BoxConstraints(maxHeight: screenHeight * 0.4),
        child: Card(
          color: cardColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.directions_bike, color: iconColor),
                      SizedBox(width: 8),
                      RichText(
                        text: TextSpan(
                          text: 'Modele : ',
                          style: TextStyle(
                            color: accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: savedVehicle?.model,
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      columnText(
                        'Type',
                        savedVehicle?.type ?? 'N/A',
                        accentColor,
                        textColor,
                      ),
                      columnText(
                        'Annee',
                        DateFormat('yyyy').format(savedVehicle!.year),
                        accentColor,
                        textColor,
                      ),
                      columnText(
                        'Couleur',
                        savedVehicle.color,
                        accentColor,
                        textColor,
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'matricule : ',
                        style: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        savedVehicle.registerNbr ?? 'N/A',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 18,
                        color: subtitleColor,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Date expiration : ',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat(
                          'yyyy-MM-dd',
                        ).format(savedVehicle.insuranceExpr),
                        style: TextStyle(color: textColor),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  Text(
                    'Document',
                    style: TextStyle(
                      color: accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Carte grise', style: TextStyle(color: textColor)),
                      Text('Verifie', style: TextStyle(color: kPrimaryGreen)),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Permis de conduite',
                        style: TextStyle(color: textColor),
                      ),
                      Text('Verifie', style: TextStyle(color: kPrimaryGreen)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget columnText(
    String title,
    String value,
    Color titleColor,
    Color valueColor,
  ) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: titleColor),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.w500, color: valueColor),
        ),
      ],
    );
  }
}
