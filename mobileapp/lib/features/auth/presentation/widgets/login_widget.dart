import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/auth/presentation/pages/register_page.dart';

class LoginWidget extends ConsumerStatefulWidget {
  const LoginWidget({super.key});

  @override
  ConsumerState<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends ConsumerState<LoginWidget> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(darkModeProvider);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final backgroundColor = isDarkMode ? kPrimaryDark : kSecondaryWhite;
    final textColor1 = isDarkMode ? kPrimaryWhite : kPrimaryDark;
    final textFieldColor = isDarkMode ? kSecondaryDark : kWhiteGray;

    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Container(
          height: height * 0.68,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Bienvenue !',
                          style: TextStyle(
                            fontSize: 33,
                            color: textColor1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        AutoSizeText(
                          'Connectez-vous pour accéder à votre\nespace.',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(fontSize: 14, color: textColor1),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 35),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: textFieldColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      controller: _phoneController,

                      keyboardType: TextInputType.phone,
                      style: TextStyle(color: textColor1),
                      decoration: InputDecoration(
                        iconColor: textColor1,
                        icon: Icon(Icons.phone),
                        border: InputBorder.none,
                        fillColor: textColor1,
                        hintText: 'Numéro de téléphone',
                        hintStyle: TextStyle(color: textColor1),
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: width * 0.6,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE13838),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Se connecter',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFF5F5F5),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width * 0.6,

                        child: AutoSizeText(
                          "Vous ne possédez pas de compte ? ",
                          style: TextStyle(
                            fontSize: 15,
                            color: textColor1,
                            fontWeight: FontWeight.w500,
                          ),
                          maxFontSize: 16,
                          minFontSize: 10,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: width * 0.26,
                          child: AutoSizeText(
                            "S'inscrire.",
                            style: TextStyle(
                              color: Color(0xFFE13838),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxFontSize: 15,
                            minFontSize: 13,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(fontSize: 12, color: textColor1),
                    children: [
                      const TextSpan(
                        text: "En vous connectant, vous acceptez nos ",
                      ),
                      TextSpan(
                        text: "conditions d’utilisation et notre politique de confidentialité.",
                        style: TextStyle(color: Colors.red), // Texte en rouge
                      ),
                    ],
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
