import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';

class AdvertisementCard extends ConsumerWidget {
  const AdvertisementCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);

    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width =
              constraints.maxWidth > 600
                  ? 500.0
                  : MediaQuery.of(context).size.width * 0.85;
          final height = width * 0.5;

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: SizedBox(
              width: width,
              height: height,
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.4,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            color: Colors.red,
                            padding: EdgeInsets.all(width * 0.04),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  'Experience our\ndelicious new dish',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.04,
                                  ),
                                  maxLines: 3,
                                  minFontSize: 10,
                                ),
                                const SizedBox(height: 10),
                                AutoSizeText(
                                  '30% OFF',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.07,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  minFontSize: 18,
                                ),
                              ],
                            ),
                          ),

                          Positioned(
                            top: -20,
                            right: 10,
                            child: CircleAvatar(
                              radius: width * 0.06,
                              backgroundColor: Colors.amber,
                              child: CircleAvatar(
                                radius: width * 0.045,
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -10,
                            left: -10,
                            child: CircleAvatar(
                              radius: width * 0.06,
                              backgroundColor: Colors.amber,
                              child: CircleAvatar(
                                radius: width * 0.045,
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Right image side
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      child: Image.network(
                        'https://media.timeout.com/images/106194093/1920/1440/image.webp',
                        fit: BoxFit.cover,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
