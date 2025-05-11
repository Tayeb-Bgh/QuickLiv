import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/constants.dart';

class BubbleItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const BubbleItem({Key? key, required this.icon, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: kSecondaryWhite,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: kDarkGray, blurRadius: 2, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: kPrimaryRed),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: kPrimaryRed,
            ),
          ),
        ],
      ),
    );
  }
}
