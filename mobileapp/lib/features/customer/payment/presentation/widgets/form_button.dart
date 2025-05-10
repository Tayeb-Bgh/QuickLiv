import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/constants/constants.dart';

class FormButton extends ConsumerWidget {
  final Color bgColor;
  final String text;
  final Function onClick;
  const FormButton({
    super.key,
    required this.bgColor,
    required this.text,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 25,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          padding: EdgeInsets.symmetric(horizontal: 20),
        ),
        onPressed: () {
          onClick();
        },
        child: Text(text, style: TextStyle(color: kSecondaryWhite)),
      ),
    );
  }
}
