import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/core/constants/constants.dart';

class BusinessStoryBtn extends ConsumerWidget {
  final Grocery grocery;
  final bool isDarkMode;

  const BusinessStoryBtn({
    super.key,
    required this.grocery,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    final Color textColor = isDarkMode ? kLightGray : kPrimaryBlack;

    return Column(
      children: [
        CircleAvatar(child: Image.network(grocery.imgUrl)),
        AutoSizeText(
          grocery.name,
          style: TextStyle(fontFamily: 'Roboto', color: textColor),
          minFontSize: 10,
          maxFontSize: 12,
          maxLines: 1,
        ),
      ],
    );
  }
}
