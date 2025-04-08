import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/constants.dart';

class FailureWidget extends StatelessWidget {
  final Object err;
  final bool show;
  final VoidCallback onPressed;

  const FailureWidget({
    super.key,
    required this.err,
    required this.onPressed,
    required this.show,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 60, color: kPrimaryRed),
            const SizedBox(height: 20),
            Text(
              show == true
                  ? 'Error : $err'
                  : 'Oups ! Une erreur est survenue 😕',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'Impossible de charger les données.\nVérifie ta connexion Internet.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            ElevatedButton.icon(
              onPressed: () => onPressed,
              icon: const Icon(Icons.refresh),
              label: const Text("Actualiser"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                backgroundColor: kPrimaryRed,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
