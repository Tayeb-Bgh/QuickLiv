import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';

import 'package:mobileapp/features/maps_example/polyline_current_to_destination.dart';

class MapSection extends ConsumerWidget {
  const MapSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isDarkMode = ref.watch(darkModeProvider);
    final fontColor = isDarkMode ? kWhiteGray : kDarkGray;

    return Column(
      children: [
        Text(
          'Itinéraire',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: fontColor,
          ),
        ),
        SizedBox(height: height * 0.006),
        Divider(color: fontColor, thickness: 3, height: 0),
        SizedBox(height: height * 0.01),
        Row(
          children: [
            Icon(Icons.radio_button_unchecked, size: 20, color: fontColor),
            SizedBox(width: 4),
            Expanded(
              child: DottedLine(
                direction: Axis.horizontal,
                lineLength: double.infinity,
                lineThickness: 4.0,
                dashLength: 8.0,
                dashColor: fontColor,
              ),
            ),
            Icon(Icons.store_mall_directory, size: 24, color: Colors.red),
          ],
        ),
        SizedBox(height: height * 0.01),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: width * 0.7,
            height: height * 0.2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Stack(
              children: [
                Positioned.fill(child: GoogleMapsPageToDest()),
                Positioned(
                  bottom: 10,
                  left: width * 0.15,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryRed,
                    ),
                    onPressed: () {},
                    child: const AutoSizeText(
                      "Ouvrir la navigation",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: height * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Icon(Icons.location_on_outlined, color: fontColor, size: 16),
                AutoSizeText(
                  "3.6km restantes",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: fontColor,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.timelapse, color: fontColor, size: 16),
                AutoSizeText(
                  "10 min restantes",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: fontColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
