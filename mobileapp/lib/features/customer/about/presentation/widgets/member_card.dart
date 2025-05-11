import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MemberCard extends ConsumerWidget {
  final String name;
  final String specialty;
  final String description;
  final IconData icon;
  final String githubUrl;
  final WidgetRef ref;

  const MemberCard({
    required this.name,
    required this.specialty,
    required this.description,
    required this.icon,
    required this.githubUrl,
    required this.ref,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);

    final Color backColor = isDarkMode ? kDarkGray : kSecondaryWhite;
    final Color textColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    final Color iconColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: KSecondaryRed),
      ),
      color: backColor,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, size: 16, color: kPrimaryRed),
                      const SizedBox(width: 8),
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    specialty,
                    style: TextStyle(
                      fontSize: 12,
                      color: kPrimaryRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(fontSize: 12, color: textColor),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                try {
                  await Clipboard.setData(ClipboardData(text: githubUrl));

                  Fluttertoast.showToast(
                    msg: 'GitHub URL copied to clipboard!',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } catch (e) {
                  Fluttertoast.showToast(
                    msg: 'Failed to copy GitHub URL.',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: backColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FaIcon(
                  FontAwesomeIcons.github,
                  size: 23,
                  color: iconColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
