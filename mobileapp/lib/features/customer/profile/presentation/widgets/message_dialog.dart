import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageDialog extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    final Color backColor = isDarkMode ? Color(0xFF282525) : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;

    return Dialog(
      backgroundColor: backColor,
      child: Container(
        padding: EdgeInsets.all(16.0),
        width: 350,
        height: 270,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Dossier soumis',
              style: TextStyle(
                fontSize: 25,
                color: const Color.fromARGB(255, 222, 71, 60),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Votre dossier a déjà été soumis, le traitement de votre demande est en cours. Nous vous tiendrons informé de l\'avancement.',
              style: TextStyle(
                fontSize: 17,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25.0), // Added more space for the button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                backgroundColor: Color(0xFFDC473C), // Custom button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Ok',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
