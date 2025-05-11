import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/constants.dart';

class RowCounter {
  static Widget buildStepCircle({
    required String number,
    bool isActive = false,
  }) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: isActive ? Colors.redAccent : kLightGray,
      child: AutoSizeText(
        number,
        style: TextStyle(
          fontFamily: 'Roboto',
          color: isActive ? Colors.white : kPrimaryBlack,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          shadows:
              isActive
                  ? [
                    const Shadow(
                      offset: Offset(0, 3),
                      blurRadius: 5,
                      color: Colors.black45,
                    ),
                  ]
                  : null,
        ),
      ),
    );
  }

  static Widget buildConnector(double width, double height) {
    return Container(
      width: width * 0.082,
      height: height * 0.006,
      decoration: const BoxDecoration(color: kLightGray),
    );
  }
}
