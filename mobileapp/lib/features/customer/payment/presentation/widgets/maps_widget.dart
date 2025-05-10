import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/maps_example/current_pos_utilisation.dart';

class MapsWidget extends ConsumerWidget {
  const MapsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);
    final Color sectionTxtColor = isDarkMode ? kLightGray : kMediumGray;
    final width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Localisation",
          style: TextStyle(
            color: sectionTxtColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Container(
          width: width,
          height: 5,
          decoration: BoxDecoration(
            color: sectionTxtColor,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(height: 250, child: const GoogleMapsPage()),
      ],
    );
  }
}
