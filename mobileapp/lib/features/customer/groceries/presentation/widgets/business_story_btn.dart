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
    final Color textColor = isDarkMode ? kLightGray : kPrimaryBlack;
    final radius = MediaQuery.of(context).size.height * 0.04;
    final textWidth = radius * 3;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(3), // Red stroke thickness
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: kPrimaryRed, // Outer red ring
          ),
          child: Container(
            padding: const EdgeInsets.all(3), // GAP between red ring and image
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kPrimaryDark,
            ),
            child: CircleAvatar(
              radius: radius,
              backgroundImage: NetworkImage(grocery.imgUrl),
            ),
          ),
        ),
        SizedBox(
          width: textWidth,
          child: Text(
            grocery.name,
            style: TextStyle(color: textColor, fontSize: 10),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
