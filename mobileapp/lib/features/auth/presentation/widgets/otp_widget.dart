import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpWidget extends StatefulWidget {
  const OtpWidget({super.key});

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        height: height * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text(
                  'Saiser le code !',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Veuillez saisir le code d’accès qui vous a été envoyé par SMS.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 35),
                Container(
                  child: OtpTextField(
                    numberOfFields: 5,
                    filled: true,
                    borderColor: Color(0xFF512DA8),
                    borderRadius: BorderRadius.circular(20),
                    fieldWidth: width * 0.13,
                    fillColor: Color(0xFFD9D9D9),
                    showFieldAsBox: true,
                    textStyle: TextStyle(),
                    onCodeChanged: (String code) {},
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
                      style: TextStyle(fontSize: 16, color: Color(0xFFF5F5F5)),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Vous n’avez pas reçu de code ? "),
                    Text(
                      "Renvoyer",
                      style: TextStyle(
                        color: Color(0xFFE13838),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                "En vous connectant, vous acceptez nos conditions d’utilisation et notre politique de confidentialité.",
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
