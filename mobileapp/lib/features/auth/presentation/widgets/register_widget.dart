import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/auth/presentation/pages/login_page.dart';
import 'package:mobileapp/features/confidentiality/presentation/pages/confidentialiy_page.dart';
import 'package:mobileapp/features/confidentiality/presentation/widgets/confidentiality.dart';

class RegisterWidget extends ConsumerStatefulWidget {
  const RegisterWidget({super.key});

  @override
  ConsumerState<RegisterWidget> createState() => _TestState();
}

class _TestState extends ConsumerState<RegisterWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    bool isChecked = false;
    bool isDarkMode = ref.watch(darkModeProvider);

    final backgroundColor = isDarkMode ? kPrimaryDark : kSecondaryWhite;
    final textColor1 = isDarkMode ? kPrimaryWhite : kPrimaryDark;
    final textFieldColor = isDarkMode ? kSecondaryDark : kWhiteGray;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  'Bienvenue !',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: textColor1,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Créez votre compte et commencez à vous\nfaire livrer',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textColor1, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          _buildInput(Icons.person, 'Nom', textColor1, textFieldColor),
          SizedBox(height: height * 0.015),
          _buildInput(Icons.person, 'Prénom', textColor1, textFieldColor),
          SizedBox(height: height * 0.015),
          _buildInput(
            Icons.phone,
            'Numéro de téléphone',
            textColor1,
            textFieldColor,
          ),
          SizedBox(height: height * 0.015),
          _buildInput(
            Icons.calendar_today,
            'Date de naissance',
            textColor1,
            textFieldColor,
          ),
          SizedBox(height: height * 0.015),

          Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value ?? false;
                  });
                },
                activeColor: kPrimaryRed,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                ConfidentialiyPage(), // Remplacez par votre page de conditions
                      ),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: textColor1),
                      children: [
                        TextSpan(text: 'Accepter les '),
                        TextSpan(
                          text: 'termes & politiques de confidentialité.',
                          style: TextStyle(
                            color: kPrimaryRed,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: width * 0.5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(20.0),
                  backgroundColor: kPrimaryRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {},
                child: Text(
                  'S’inscrire',
                  style: TextStyle(fontSize: 16, color: kPrimaryWhite),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width * 0.6,

                child: AutoSizeText(
                  "Vous possédez deja un compte ?",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textColor1,
                  ),
                  maxFontSize: 15,
                  minFontSize: 10,
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: SizedBox(
                  width: width * 0.26,
                  child: AutoSizeText(
                    "Se connecter",
                    style: TextStyle(
                      color: kPrimaryRed,

                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    maxFontSize: 16,
                    minFontSize: 13,
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildInput(
  IconData icon,
  String hint,
  Color textColor1,
  textFieldColor,
) {
  return TextField(
    style: TextStyle(color: textColor1),
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: textColor1), // Icône en blanc
      hintText: hint,
      hintStyle: TextStyle(color: textColor1), // Hint en blanc semi-transparent
      filled: true,
      fillColor: textFieldColor, // Fond gris foncé
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
