import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/core/hive_object/customer_hive_object.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Consumer(
      builder: (context, ref, child) {
        final isDarkMode = ref.watch(darkModeProvider);
        final backgroundColor = isDarkMode ? kSecondaryDark : kPrimaryWhite;
        final fontColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
        final iconColor = isDarkMode ? kPrimaryWhite : kSecondaryDark;

        final box = Hive.box<CustomerHiveObject>('customerBox');
        CustomerHiveObject? savedCustomer = box.get('currentCustomer');
        final String firstName = savedCustomer?.firstName ?? 'Prénom';
        final String lastName = savedCustomer?.lastName ?? 'Nom';
        final String phoneNumber = savedCustomer?.phone ?? 'Téléphone';
        final String registrationDate =
            savedCustomer != null
                ? DateFormat('dd/MM/yyyy').format(savedCustomer.registerDate)
                : 'Date d\'inscription';

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: width * 0.9,
            height: height * 0.2,
            padding: EdgeInsets.symmetric(vertical: height * 0.02),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '$firstName $lastName',
                  style: TextStyle(
                    color: fontColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  icon: Icons.phone,
                  title: 'Téléphone',
                  value: formatPhone(phoneNumber),
                  fontColor: fontColor,
                  subtitleColor: iconColor,
                  iconColor: iconColor,
                ),
                _buildInfoRow(
                  icon: Icons.calendar_today,
                  title: 'Date d\'inscription',
                  value: registrationDate,
                  fontColor: fontColor,
                  subtitleColor: iconColor,
                  iconColor: iconColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    required Color fontColor,
    required Color subtitleColor,
    required Color iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 12, color: subtitleColor)),
              Text(
                value,
                style: TextStyle(
                  color: fontColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
