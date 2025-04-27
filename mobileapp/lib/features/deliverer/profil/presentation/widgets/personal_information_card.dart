import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/core/hive_object/deliverer_hive_object.dart';

class PersonalInformationCard extends StatelessWidget {
  final DelivererHiveObject? deliverer;
  const PersonalInformationCard({super.key, this.deliverer});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
 

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: screenHeight * 0.3),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(
                  Icons.phone,
                  'Telephone:',
                  deliverer?.phone ?? 'N/A',
                ),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.email, 'Email:', deliverer?.email ?? 'N/A'),
                const SizedBox(height: 12),
                _buildInfoRow(
                  Icons.location_on,
                  'Adresse:',
                  deliverer?.adrs ?? 'N/A',
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  Icons.date_range,
                  'Date d’inscription:',
                  DateFormat('yyyy-MM-dd').format(deliverer!.registerDate),
                
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon),
        SizedBox(
          child: AutoSizeText(
            label,
            maxLines: 1,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: AutoSizeText(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
