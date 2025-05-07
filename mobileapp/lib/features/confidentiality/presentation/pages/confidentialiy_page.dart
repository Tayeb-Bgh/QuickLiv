import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobileapp/features/auth/presentation/pages/login_page.dart';
import 'package:mobileapp/features/confidentiality/presentation/widgets/confidentiality.dart';
import 'package:mobileapp/features/customer/gesProfil/DevLivreur/presentation/pages/deliverer_first_page.dart';
import 'package:mobileapp/features/customer/gesProfil/DevLivreur/presentation/pages/deliverer_second_page.dart';
import 'package:mobileapp/features/customer/gesProfil/DevLivreur/presentation/pages/deliverer_third_page.dart';

class ConfidentialiyPage extends StatefulWidget {
  const ConfidentialiyPage({super.key});

  @override
  State<ConfidentialiyPage> createState() => _ConfidentialiyPageState();
}

class _ConfidentialiyPageState extends State<ConfidentialiyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 25, 24, 24).withOpacity(0.2),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 25, 24, 24).withOpacity(0.2),
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: SvgPicture.asset(
                'assets/images/Vector.svg',
                color: Colors.white,
                width: 20,
                height: 20,
              ),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Confidentialité',
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(0, 3),
                blurRadius: 5,
                color: Colors.black45,
              ),
            ],
          ),
        ),
      ),
      body: Confidentiality(),
    );
  }
}
