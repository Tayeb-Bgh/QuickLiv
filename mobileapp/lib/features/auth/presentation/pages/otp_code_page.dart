import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/auth/presentation/widgets/login_appbar.dart';
import 'package:mobileapp/features/auth/presentation/widgets/otp_code_widget.dart';

class OtpCodePage extends ConsumerStatefulWidget {
  final int phoneNumber;
  const OtpCodePage( {super.key, required this.phoneNumber});

  @override
  ConsumerState<OtpCodePage> createState() => _OtpCodePageState();
}

class _OtpCodePageState extends ConsumerState<OtpCodePage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(darkModeProvider);
    final height = MediaQuery.of(context).size.height;

    final backgroundColor = isDarkMode ? kPrimaryDark : kSecondaryWhite;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: height * 0.31,
                left: 0,
                right: 0,
                child: OtpCodeWidget(phoneNumber: widget.phoneNumber ),
              ),
              Positioned(top: 0, left: 0, right: 0, child: LoginAppBar()),
            ],
          ),
        ),
      ),
    );
  }
}
