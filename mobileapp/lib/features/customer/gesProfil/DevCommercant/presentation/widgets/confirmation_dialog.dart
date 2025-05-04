import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfirmationDialog extends ConsumerWidget {
  final VoidCallback onConfirm;

  ConfirmationDialog({required this.onConfirm});

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
        height: 282,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Confirmer l\'envoi',
              style: TextStyle(
                fontSize: 25,
                color: const Color.fromARGB(255, 222, 71, 60),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Une fois avoir soumis le formulaire vous recevrez après quelques jours un rendez-vous pour passer un entretien afin de devenir un partenaire.',
              style: TextStyle(
                fontSize: 17,
                color: textColor, // Apply text color dynamically
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // "Annuler" button with smaller cross icon
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 50,
                        height: 45,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 90, 89, 89),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Transform.scale(
                            scale: 0.7,
                            child: SvgPicture.asset(
                              'assets/images/cross.svg',
                              color: Colors.white,
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 25),

                // "Confirmer" button with slightly larger done icon
                TextButton(
                  onPressed: () {
                    onConfirm();
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 50,
                        height: 45,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 219, 52, 52),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Transform.scale(
                            scale: 1.1,
                            child: SvgPicture.asset(
                              'assets/images/done.svg',
                              color: Colors.white,
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
