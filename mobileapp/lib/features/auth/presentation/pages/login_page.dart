import 'package:flutter/material.dart';
import 'package:mobileapp/features/auth/presentation/widgets/login_appbar.dart';
import 'package:mobileapp/features/auth/presentation/widgets/login_widget.dart';


class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: height * 0.25,
                left: 0,
                right: 0,
                child: LoginPage(),
              ),
              Positioned(top: 0, left: 0, right: 0, child: LoginAppBar()),
            ],
          ),
        ),
      ),
    );
  }
}