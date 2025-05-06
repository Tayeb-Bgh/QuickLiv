import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/hive_object/deliverer_hive_object.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';

class PersonalInformationCard extends ConsumerWidget {
  final DelivererHiveObject? deliverer;
  const PersonalInformationCard({super.key, this.deliverer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isDarkMode = ref.watch(darkModeProvider);

    // Définition des couleurs adaptatives selon le mode
    final backgroundColor = isDarkMode ? kSecondaryDark : kPrimaryWhite;
    final textColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    final accentColor = kPrimaryRed; // On garde le rouge comme accent

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: screenHeight * 0.3),
        child: Card(
          elevation: 4,
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(
                  Icons.phone,
                  'Telephone:',
                  deliverer?.phone ?? 'N/A',
                  textColor,
                  accentColor,
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  Icons.email,
                  'Email:',
                  deliverer?.email ?? 'N/A',
                  textColor,
                  accentColor,
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  Icons.location_on,
                  'Adresse:',
                  deliverer?.adrs ?? 'N/A',
                  textColor,
                  accentColor,
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  Icons.date_range,
                  'Date d\'inscription:',
                  deliverer != null
                      ? DateFormat('yyyy-MM-dd').format(deliverer!.registerDate)
                      : 'N/A',
                  textColor,
                  accentColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value,
    Color textColor,
    Color iconColor,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 8),
        SizedBox(
          child: AutoSizeText(
            label,
            maxLines: 1,
            style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: AutoSizeText(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: textColor),
          ),
        ),
      ],
    );
  }
}
