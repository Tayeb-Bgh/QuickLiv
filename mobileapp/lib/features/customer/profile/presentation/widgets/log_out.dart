import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/auth/presentation/providers/auth_provider.dart';
import 'package:mobileapp/features/customer/profile/presentation/pages/profile_popup_page.dart';
import 'package:mobileapp/features/customer/skeleton/presentation/customer_skeleton.dart';

class LogoutProfile extends ConsumerWidget {
  const LogoutProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkProvider = ref.watch(darkModeProvider);
    final secureStorage = ref.read(secureStorageProvider);
    final backgroundColor = isDarkProvider ? kPrimaryDark : kPrimaryWhite;
    final fontColor = isDarkProvider ? kPrimaryWhite : kPrimaryDark;

    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      shadowColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 5),
            Text(
              "Êtes vous sûr de vous déconnecter ?",
              style: TextStyle(
                fontSize: 20,
                color: fontColor,
                fontFamily: 'Roboto',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Color(0xFF504E4E),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.close, color: kPrimaryWhite, size: 24),
                    onPressed: () {
                      print('Close pressed');
                      Navigator.pop(context);
                      showProfilePopupPage(context);
                    },
                    padding: EdgeInsets.zero,
                  ),
                ),
                SizedBox(width: 55),

                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: kPrimaryRed,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: kPrimaryBlur,
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.check, color: kPrimaryWhite, size: 24),
                    onPressed: () async {
                      print('Logout pressed');

                      try {
                        await secureStorage.delete(key: 'authToken');

                        final token = await secureStorage.read(
                          key: 'authToken',
                        );
                        print('Token after delete: $token');

                        ref.invalidate(jwtTokenProvider);

                        if (context.mounted) {
                          ref.read(darkModeProvider.notifier).state = false;
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => CustomerSkeleton(),
                            ),
                            (route) => false,
                          );
                        }
                      } catch (e) {
                        print('Error during logout: $e');
                      }
                    },
                    padding: EdgeInsets.zero,
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
