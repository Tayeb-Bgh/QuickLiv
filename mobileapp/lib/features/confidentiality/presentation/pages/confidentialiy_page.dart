import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/confidentiality/presentation/widgets/confidentiality.dart';

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kPrimaryWhite),
          onPressed: () {
            Navigator.pop(context); // Go back when pressed
          },
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        centerTitle: true,
        backgroundColor: kPrimaryRed,
        title: Text(
          'Politique de confidentialité',
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Confidentiality(),
    );
  }
}
