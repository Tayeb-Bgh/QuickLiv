import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/auth/presentation/providers/auth_provider.dart';
import 'package:mobileapp/features/customer/about/presentation/pages/about_page.dart';
import 'package:mobileapp/features/customer/gesProfil/DevCommercant/presentation/pages/be_trader_skeleton.dart';
import 'package:mobileapp/features/customer/gesProfil/DevLivreur/presentation/pages/be_deliverer_skeleton.dart';
import 'package:mobileapp/features/customer/profile/presentation/widgets/log_out.dart';
import 'package:mobileapp/features/customer/profile/presentation/widgets/message_dialog.dart';
import 'package:mobileapp/features/customer/profile/presentation/widgets/profil_card.dart';
import 'package:mobileapp/features/customer/profile/presentation/widgets/profile_top_bar.dart';
import 'package:light_dark_theme_toggle/light_dark_theme_toggle.dart';
import 'package:http/http.dart' as http;

class ProfilePopup extends ConsumerStatefulWidget {
  const ProfilePopup({super.key});

  @override
  _ProfilePopupState createState() => _ProfilePopupState();
}

class _ProfilePopupState extends ConsumerState<ProfilePopup> {
  Future<void> checkDelivererStatus() async {
    final token = await ref.read(jwtTokenProvider.future);
    final url = await ApiConfig.getBaseUrl();

    try {
      final response = await http.get(
        Uri.parse('$url/gesProfil/get-client-status'),
        headers: {'Authorization': 'Bearer $token'},
      );

      final responseData = jsonDecode(response.body);

      if (responseData['isSubmittedDelivererCust'] == 1) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return MessageDialog();
          },
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BeDelivererSkeleton()),
        );
      }
    } catch (e) {
      print('Erreur lors de la récupération du statut : $e');
    }
  }

  Future<void> checkDelivererStatus2() async {
    final token = await ref.read(jwtTokenProvider.future);
    final url = await ApiConfig.getBaseUrl();

    try {
      final response = await http.get(
        Uri.parse('$url/gesProfil/get-client-partner-status'),
        headers: {'Authorization': 'Bearer $token'},
      );

      final responseData = jsonDecode(response.body);

      if (responseData['isSubmittedPartnerCust'] == 1) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return MessageDialog();
          },
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BeTraderSkeleton()),
        );
      }
    } catch (e) {
      print('Erreur lors de la récupération du statut : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isDarkMode = ref.watch(darkModeProvider);
    final backgroumdColor = isDarkMode ? kPrimaryDark : kPrimaryWhite;
    final iconColor = isDarkMode ? kDarkGray : kSecondaryWhite;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(width * 0.05),
          bottomRight: Radius.circular(width * 0.05),
        ),
        color: backgroumdColor,
      ),
      child: Column(
        children: [
          Stack(
            children: [
              CustomPaint(
                size: Size(double.infinity, height * 0.38),
                painter: ProfileTopBar(isDarkMode: isDarkMode),
              ),
              Positioned(
                top: width * 0.17,
                left: 20,
                right: 20,
                child: ProfileCard(),
              ),
              Positioned(
                top: width * 0.085,
                left: width * 0.42,
                child: Container(
                  width: width * 0.15,
                  height: width * 0.15,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: height * 0.31,
                left: width * 0.83,
                child: LightDarkThemeToggle(
                  value: isDarkMode,
                  onChanged: (bool value) {
                    ref.read(darkModeProvider.notifier).state = value;
                  },
                  size: width * 0.07,
                  themeIconType: ThemeIconType.classic,
                  color: iconColor,
                  tooltip: 'Toggle Theme',
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                ),
              ),
              Positioned(
                top: height * 0.312,
                right: width * 0.88,
                child: IconButton(
                  color: iconColor,
                  iconSize: width * 0.07,
                  onPressed: () async {
                    print('Logout pressed');
                    Navigator.pop(context); // just close the dialog
                    showDialog(
                      context: context,
                      builder: (context) => LogoutProfile(),
                    );
                  },
                  icon: Icon(Icons.logout),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _createRow(
                    width,
                    height,
                    'Devenir Livreur',
                    Icons.delivery_dining,
                    ref,
                  ),
                  _createRow(
                    width,
                    height,
                    'Devenier Partenaire',
                    Icons.business_center,
                    ref,
                  ),
                  _createRow(
                    width,
                    height,
                    'A propos de nous',
                    Icons.info,
                    ref,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _createRow(double width, double height, String text, IconData icon, ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    final backgroundColor = isDarkMode ? kSecondaryDark : kLightGrayWhite;
    final textColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    final iconColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Container(
            width: width * 0.9,
            height: height * 0.04,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              splashColor: kLightGreen,
              onTap: () {
                if (text == 'Devenir Livreur') {
                  checkDelivererStatus(); // Appeler la fonction pour vérifier le statut
                } else if (text == 'Devenier Partenaire') {
                  checkDelivererStatus2();
                } else if (text == 'A propos de nous') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                }
              },
              child: Row(
                spacing: width * 0.02,
                children: [
                  SizedBox(width: width * 0.02),
                  Icon(icon, size: width * 0.06, color: iconColor),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
