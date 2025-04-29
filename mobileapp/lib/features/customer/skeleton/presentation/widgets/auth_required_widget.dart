import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/auth/presentation/pages/login_page.dart';

class AuthRequiredWidget extends ConsumerWidget {
  const AuthRequiredWidget({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    return Center(
      
      child: Container(
        color: isDarkMode ?  kPrimaryDark : Colors.white,
        child: Padding(
         
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_outline, size: 60, color: isDarkMode ? kWhiteGray : kPrimaryDark),
              const SizedBox(height: 20),
              Text(
                'Fonctionnalité réservée',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryRed,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Connectez-vous pour accéder à cette fonctionnalité, comme l’utilisation de vos coupons ou la commande de plats.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: isDarkMode ? kWhiteGray : kPrimaryDark),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryRed,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: const Text(
                  'Se connecter',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
