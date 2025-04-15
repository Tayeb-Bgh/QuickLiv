import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';

class OtpCodeWidget extends ConsumerStatefulWidget {
  const OtpCodeWidget({super.key});

  @override
  ConsumerState<OtpCodeWidget> createState() => _OtpCodeWidgetState();
}

class _OtpCodeWidgetState extends ConsumerState<OtpCodeWidget> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(darkModeProvider);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;


    final textColor1 = isDarkMode ? kPrimaryWhite : kPrimaryDark;
    final textFieldColor = isDarkMode ? kSecondaryDark : kWhiteGray;
    final borderTextFieldColor = isDarkMode ? kPrimaryWhite : kDarkGray;
    

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: height * 0.68,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                            'Saiser le code !',
                            style: TextStyle(
                              fontSize: 31,
                              fontWeight: FontWeight.bold,
                              color: textColor1,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Veuillez saisir le code d’accès qui vous a été envoyé par Telegram.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: textColor1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                OtpTextField(
                  numberOfFields: 5,
                  filled: true,
                  cursorColor: kPrimaryRed,
                  borderRadius: BorderRadius.circular(20),
                  fieldWidth: width * 0.14,
                  enabledBorderColor: borderTextFieldColor,
                  focusedBorderColor: kPrimaryRed,
                  fieldHeight: width * 0.14,
                  fillColor: textFieldColor,
                  showFieldAsBox: true,
                  textStyle: TextStyle(color: textColor1),
                  onCodeChanged: (String code) {},
                ),

                SizedBox(height: 30),

                SizedBox(
                  width: width * 0.6,
                  height: height * 0.055,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE13838),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Se connecter',
                      style: TextStyle(fontSize: 16, color: Color(0xFFF5F5F5)),
                    ),
                  ),
                ),

                SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width * 0.5,

                      child: AutoSizeText(
                        "Vous n’avez pas reçu de code ? ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: textColor1,
                        ),
                        maxFontSize: 16,
                        minFontSize: 10,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(width: 5),
                    SizedBox(
                      width: width * 0.2,
                      child: AutoSizeText(
                        "Renvoyer",
                        style: TextStyle(
                          color: Color(0xFFE13838),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxFontSize: 16,
                        minFontSize: 10,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(fontSize: 12, color: textColor1),
                  children: [
                    const TextSpan(
                      text: "En vous connectant, vous acceptez nos ",
                    ),
                    TextSpan(
                      text:
                          "conditions d’utilisation et notre politique de confidentialité.",
                      style: TextStyle(color: Colors.red), // Texte en rouge
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
