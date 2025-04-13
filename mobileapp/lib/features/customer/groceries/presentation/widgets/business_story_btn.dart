import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/core/constants/constants.dart';

class BusinessStoryBtn extends StatelessWidget {
  final Grocery grocery;
  final bool isDarkMode;

  BusinessStoryBtn({
    super.key,
    required this.grocery,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
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
