import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/gesProfil/DevCommercant/business/usercases/validateTrader.dart';
import 'package:mobileapp/features/customer/gesProfil/DevCommercant/presentation/providers/from_data_provider.dart';

class TraderSecondPage extends ConsumerStatefulWidget {
  const TraderSecondPage({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  @override
  ConsumerState<TraderSecondPage> createState() => _DelivererSecondPageState();
}

class _DelivererSecondPageState extends ConsumerState<TraderSecondPage> {
  String? _type;

  final TextEditingController nomController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();
  final TextEditingController telController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numRegCommerceController =
      TextEditingController();

  final Validatetrader validator = Validatetrader();

  void _updateFormData() {
    final formData = ref.read(formDataProvider.notifier);
    formData.updateField('nomCommerce', nomController.text);
    formData.updateField('adresseCommerce', adresseController.text);
    formData.updateField('telephoneCommerce', telController.text);
    formData.updateField('email', emailController.text);
    formData.updateField('numRegCommerce', numRegCommerceController.text);
    formData.updateField('type', _type ?? '');
  }

  @override
  void initState() {
    super.initState();
    final formData = ref.read(formDataProvider);
    nomController.text = formData['nomCommerce'] ?? '';
    adresseController.text = formData['adresseCommerce'] ?? '';
    telController.text = formData['telephoneCommerce'] ?? '';
    emailController.text = formData['email'] ?? '';
    numRegCommerceController.text = formData['numRegCommerce'] ?? '';
    _type = formData['type'];
  }

  String? _nomError;
  String? _adresseError;
  String? _telError;
  String? _emailError;
  String? _numRegCommerceError;
  String? _typeError;

  bool _isFormValid() {
    bool isValid = true;

    if (nomController.text.isEmpty) {
      isValid = false;
      setState(() {
        _nomError = "Veuillez remplir ce champ.";
      });
    } else {
      setState(() {
        _nomError = null;
      });
    }

    if (adresseController.text.isEmpty) {
      isValid = false;
      setState(() {
        _adresseError = "Veuillez remplir ce champ.";
      });
    } else {
      setState(() {
        _adresseError = null;
      });
    }

    if (telController.text.isEmpty ||
        !validator.validatePhoneNumber(telController.text)) {
      isValid = false;
      setState(() {
        _telError = "Veuillez remplir ce champ correctement.";
      });
    } else {
      setState(() {
        _telError = null;
      });
    }

    if (emailController.text.isEmpty ||
        !validator.validateEmail(emailController.text)) {
      isValid = false;
      setState(() {
        _emailError = "Veuillez remplir ce champ correctement.";
      });
    } else {
      setState(() {
        _emailError = null;
      });
    }

    if (numRegCommerceController.text.isEmpty) {
      isValid = false;
      setState(() {
        _numRegCommerceError = "Veuillez remplir ce champ.";
      });
    } else {
      setState(() {
        _numRegCommerceError = null;
      });
    }

    if (_type == null) {
      isValid = false;
      setState(() {
        _typeError = "Veuillez sélectionner un type.";
      });
    } else {
      setState(() {
        _typeError = null;
      });
    }

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final isDarkMode = ref.watch(darkModeProvider);

    final Color backColor = isDarkMode ? kPrimaryDark : kSecondaryWhite;
    final Color textColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    final Color textFieldColor = isDarkMode ? kDarkGray : kWhiteGray;
    final Color circleColor = isDarkMode ? kDarkGray : kWhiteGray;

    List<String> typeOptions = [
      'Restaurant',
      'Fast food',
      'Pizzeria',
      'Boulangerie',
      'Patisserie',
      'Epicerie',
      'Boucherie',
      'Rotisserie',
    ];

    return Scaffold(
      backgroundColor: backColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.09,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: kPrimaryRed,
                          radius: 17,
                          child: AutoSizeText(
                            '1',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: kPrimaryWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: Offset(0, 3),
                                  blurRadius: 5,
                                  color: kPrimaryBlack,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: width * 0.2,
                          height: height * 0.006,
                          decoration: BoxDecoration(color: kPrimaryRed),
                        ),
                        CircleAvatar(
                          backgroundColor: kPrimaryRed,
                          radius: 17,
                          child: AutoSizeText(
                            '2',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: kPrimaryWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: width * 0.2,
                          height: height * 0.006,
                          decoration: BoxDecoration(color: circleColor),
                        ),
                        CircleAvatar(
                          radius: 17,
                          backgroundColor: circleColor,
                          child: AutoSizeText(
                            '3',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    AutoSizeText(
                      'Informations sur le commerce',
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    _buildTextField(
                      "Nom:",
                      nomController,
                      context,
                      textColor,
                      textFieldColor,
                      _nomError,
                    ),
                    _buildTextField(
                      "Adresse:",
                      adresseController,
                      context,
                      textColor,
                      textFieldColor,
                      _adresseError,
                    ),
                    _buildTextField(
                      "Téléphone:",
                      telController,
                      context,
                      textColor,
                      textFieldColor,
                      _telError,
                    ),
                    _buildTextField(
                      "Email:",
                      emailController,
                      context,
                      textColor,
                      textFieldColor,
                      _emailError,
                    ),
                    _buildTextField(
                      "Numéro du Registre de Commerce:",
                      numRegCommerceController,
                      context,
                      textColor,
                      textFieldColor,
                      _numRegCommerceError,
                    ),
                    _buildDropdownField(
                      "Type:",
                      typeOptions,
                      _type,
                      (value) {
                        setState(() {
                          _type = value;
                        });
                         _updateFormData();
                      },
                      context,
                      textColor,
                      textFieldColor,
                    ),
                    if (_typeError != null) ...[
                      SizedBox(height: 8),
                      Text(
                        _typeError!,
                        style: TextStyle(color: kPrimaryRed, fontSize: 12),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: height * 0),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width * 0.4,
                      child: ElevatedButton(
                        onPressed: widget.onPrevious,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kDarkGray,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                        ),
                        child: AutoSizeText(
                          'Précédent',
                          style: TextStyle(
                            fontSize: 13,
                            color: kPrimaryWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_isFormValid()) {
                            _updateFormData();
                            widget.onNext();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                        ),
                        child: AutoSizeText(
                          'Suivant',
                          style: TextStyle(
                            fontSize: 13,
                            color: kPrimaryWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String labelText,
    TextEditingController controller,
    BuildContext context,
    Color textColor,
    Color textFieldColor,
    String? errorMessage,
  ) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "*",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kPrimaryRed,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 5),
            Text(
              labelText,
              style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
            ),
          ],
        ),
        SizedBox(height: height * 0.01),
        SizedBox(
          height: height * 0.05,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              fillColor: textFieldColor,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            ),
            style: TextStyle(color: textColor),
          ),
        ),
        if (errorMessage != null) ...[
          SizedBox(height: height * 0.01),
          Text(errorMessage, style: TextStyle(color: kPrimaryRed, fontSize: 12)),
        ],
        SizedBox(height: height * 0.02),
      ],
    );
  }

  _buildDropdownField(
    String labelText,
    List<String> options,
    String? selectedValue,
    ValueChanged<String?> onChanged,
    BuildContext context,
    Color textColor,
    Color textFieldColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "*",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kPrimaryRed,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 5),
            Text(
              labelText,
              style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 35,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: textFieldColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: selectedValue,
            isExpanded: true,
            dropdownColor: textFieldColor,
            style: TextStyle(color: textColor),
            onChanged: onChanged,
            items:
                options.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
