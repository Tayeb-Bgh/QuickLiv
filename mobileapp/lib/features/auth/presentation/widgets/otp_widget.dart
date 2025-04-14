import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpWidget extends ConsumerStatefulWidget {
  const OtpWidget({super.key});

  @override
  ConsumerState<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends ConsumerState<OtpWidget> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isDarkMode = ref.watch(darkModeProvider);
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
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Veuillez saisir le code d’accès qui vous a été envoyé par Telegram.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
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
                  borderColor: Color(0xFF512DA8),
                  borderRadius: BorderRadius.circular(20),
                  fieldWidth: width * 0.14,
                  fieldHeight: width * 0.14,
                  fillColor: Color(0xFFD9D9D9),
                  showFieldAsBox: true,
                  textStyle: TextStyle(),
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
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: AutoSizeText(
                "En vous connectant, vous acceptez nos conditions d’utilisation et notre politique de confidentialité.",
                style: TextStyle(fontSize: 16),
                maxFontSize: 16,
                minFontSize: 10,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
