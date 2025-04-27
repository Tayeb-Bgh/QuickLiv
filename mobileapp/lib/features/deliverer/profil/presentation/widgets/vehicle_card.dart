import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/hive_object/deliverer_hive_object.dart';
import 'package:mobileapp/core/hive_object/vehicle_hive_object.dart';
import 'package:intl/intl.dart';

class VehicleInfoCard extends StatelessWidget {
  const VehicleInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    var vehicleBox = Hive.box<VehicleHiveObject>('vehicleBox');
    VehicleHiveObject? savedVehicle = vehicleBox.get('currentVehicle');

    return Center(
      child: Container(
        constraints: BoxConstraints(maxHeight: screenHeight * 0.4),

        child: Card(
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
                      Icon(Icons.directions_bike, color: kPrimaryBlack),
                      SizedBox(width: 8),
                      RichText(
                        text: TextSpan(
                          text: 'Modele : ',
                          style: TextStyle(
                            color: kPrimaryRed,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: savedVehicle?.model,
                              style: TextStyle(
                                color: kPrimaryBlack,
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
                      columnText('Type', savedVehicle?.type ?? 'N/A'),
                      columnText(
                        'Annee',
                        DateFormat('yyyy').format(savedVehicle!.year),
                      ),
                      columnText('Couleur', savedVehicle.color),
                    ],
                  ),

                  SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'matricule : ',
                        style: TextStyle(
                          color: kPrimaryRed,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        savedVehicle?.registerNbr ?? 'N/A',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 18,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Date expiration : ',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat(
                          'yyyy-MM-dd',
                        ).format(savedVehicle!.insuranceExpr),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  Text(
                    'Document',
                    style: TextStyle(
                      color: kPrimaryRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Carte grise'),
                      Text('Verifie', style: TextStyle(color: kPrimaryGreen)),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Permis de conduite'),
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

  Widget columnText(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryRed),
        ),
        SizedBox(height: 4),
        Text(value, style: TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}
