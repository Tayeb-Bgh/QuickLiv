import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/core/constants/constants.dart';

class BusinessStoryBtn extends ConsumerWidget {
  final Grocery grocery;

  const BusinessStoryBtn({super.key, required this.grocery});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    final Color textColor = isDarkMode ? kPrimaryWhite: kPrimaryBlack;
    final radius = MediaQuery.of(context).size.height * 0.04;
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          width: width * 0.18,
          padding: const EdgeInsets.all(3), // Red stroke thickness
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: kPrimaryRed, // Outer red ring
          ),
          child: Container(
            padding: const EdgeInsets.all(3), // GAP between red ring and image
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDarkMode ? kPrimaryDark : kSecondaryWhite,
            ),
            child: CircleAvatar(
              radius: radius,
              backgroundImage: NetworkImage(grocery.imgUrl),
            ),
          ),
        ),
        const SizedBox(height: 1.6), // Space between image and text
        SizedBox(
          width: width * 0.19,
          child: AutoSizeText(
            grocery.name,
            style: TextStyle(color: textColor, fontSize: width*0.025),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
