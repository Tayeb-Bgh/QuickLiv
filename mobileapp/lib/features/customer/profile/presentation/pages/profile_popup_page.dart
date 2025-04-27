import 'package:flutter/material.dart';
import 'package:mobileapp/features/customer/profile/presentation/widgets/profile_popup.dart';

void showProfilePopupPage(BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;

  showDialog(
    context: context,
    barrierDismissible: true,  
    barrierColor: Colors.black.withOpacity(0.5),  
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        alignment: Alignment.topCenter,
        insetPadding: const EdgeInsets.all(0),
        content: Container(
          width: width,
          height: height * 0.55,
          decoration: BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.circular(20),
          ),
          child: const ProfilePopup(),
        ),
      );
    },
  );
}
