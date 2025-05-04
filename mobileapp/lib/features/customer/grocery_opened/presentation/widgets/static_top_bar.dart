import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/groceries/presentation/providers/groceries_provider.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/providers/grocery_opened_provider.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/widgets/additional_informations.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/widgets/main_informations.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/widgets/social_medias_button.dart';

class StaticTopBar extends ConsumerWidget {
  const StaticTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);
    final appBarBgColor = kPrimaryRed;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final additionalInformationsWidth = width * 0.3;
    final mainInformationsWidth = width * 0.5;
    final topBarHeight = height * 0.22;

    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Container(
            height: topBarHeight,
            width: double.infinity,
            color: appBarBgColor,
            padding: EdgeInsets.only(
              top: height * 0.07,
              left: width * 0.02,
              right: width * 0.02,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MainInformations(width: mainInformationsWidth),
                    Column(
                      children: [
                        AdditionalInformations(
                          width: additionalInformationsWidth,
                        ),
                        SocialMediasButtons(width: additionalInformationsWidth),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: height * 0.025,
            left: width * 0.02,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: width * 0.07,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
