import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/auth/business/entities/customer_entity.dart';
import 'package:mobileapp/features/auth/business/entities/custumere_entity.dart';
import 'package:mobileapp/features/auth/business/usecases/validate_inputs_usecase.dart';
import 'package:mobileapp/features/auth/presentation/pages/login_page.dart';
import 'package:mobileapp/features/auth/presentation/pages/otp_code_page.dart';
import 'package:mobileapp/features/auth/presentation/providers/auth_provider.dart';
import 'package:mobileapp/features/confidentiality/presentation/pages/confidentialiy_page.dart';
import 'package:mobileapp/features/confidentiality/presentation/widgets/confidentiality.dart';

class RegisterWidget extends ConsumerStatefulWidget {
  const RegisterWidget({super.key});

  @override
  ConsumerState<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends ConsumerState<RegisterWidget> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  bool isChecked = false;

  String? _nomError;
  String? _prenomError;
  String? _naissanceError;
  String? _phoneError;
  final ValidateInputs validator = ValidateInputs();

  @override
  void initState() {
    super.initState();
    final formData = ref.read(formDataProvider);
    _nomController.text = formData['nom'] ?? '';
    _prenomController.text = formData['prenom'] ?? '';
    _birthDateController.text = formData['naissance'] ?? '';
    _phoneController.text = formData['naissance'] ?? '';
  }

  bool _isFormValid() {
    bool isValid = true;

    if (_nomController.text.isEmpty) {
      isValid = false;
      setState(() {
        _nomError = "Veuillez remplir ce champ.";
      });
    } else {
      setState(() {
        _nomError = null;
      });
    }

    if (_prenomController.text.isEmpty) {
      isValid = false;
      setState(() {
        _prenomError = "Veuillez remplir ce champ.";
      });
    } else {
      setState(() {
        _prenomError = null;
      });
    }

    if (_birthDateController.text.isEmpty ||
        !validator.validateDateNais(_birthDateController.text)) {
      isValid = false;
      setState(() {
        _naissanceError = "Veuillez remplir ce champ.";
      });
    } else {
      setState(() {
        _naissanceError = null;
      });
    }

    if (_phoneController.text.isEmpty ||
        !validator.validatePhoneNumber(_phoneController.text)) {
      isValid = false;
      setState(() {
        _phoneError = "Veuillez remplir ce champ correctement.";
      });
    } else {
      setState(() {
        _phoneError = null;
      });
    }
    if (!isChecked) {
      isValid = false;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez accepter les termes et conditions.'),
          backgroundColor: Colors.red,
        ),
      );
    }

    return isValid;
  }

  void _OnConfirm() async {
    final formData = ref.watch(formDataProvider);
    final Customere customer = Customere(
      firstName: _nomController.text,
      lastName: _prenomController.text,
      phone: _phoneController.text,
      birthDate: _birthDateController.text,
      registerDate: DateTime.now(),
      points: 0,
      isSubmittedDeliverer: false,
      isSubmittedPartner: false,
    );
    final checkPhone = ref.read(checkPhoneUseCaseProvider);
    final exists = await checkPhone(_phoneController.text);
    
    if (exists) {
      final registerUseCase = ref.read(registerCustomerInfoUseCaseProvider);
      registerUseCase(customer);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  OtpCodePage(phoneNumber: int.parse(_phoneController.text)),
        ),
      );

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ce numéro de téléphone est déjà utilisé.'),
          backgroundColor: kPrimaryDark,
        ),
      );
    }

    print(
      'First name: ${customer.firstName}, '
      'Last name: ${customer.lastName}, '
      'Phone: ${customer.phone}, '
      'Birth date: ${customer.birthDate}, '
      'Register date: ${customer.registerDate}, '
      'Points: ${customer.points}, '
      'Deliverer: ${customer.isSubmittedDeliverer}, '
      'Partner: ${customer.isSubmittedPartner}',
    );

    
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    bool isDarkMode = ref.watch(darkModeProvider);

    final backgroundColor = isDarkMode ? kPrimaryDark : kSecondaryWhite;
    final textColor1 = isDarkMode ? kPrimaryWhite : kPrimaryDark;
    final textFieldColor = isDarkMode ? kSecondaryDark : kWhiteGray;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  'Bienvenue !',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: textColor1,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Créez votre compte et commencez à vous\nfaire livrer',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textColor1, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          _buildInput(
            _nomController,
            Icons.person,
            'Nom',
            textColor1,
            textFieldColor,
            _nomError,
          ),
          SizedBox(height: height * 0.015),
          _buildInput(
            _prenomController,
            Icons.person,
            'Prénom',
            textColor1,
            textFieldColor,
            _prenomError,
          ),
          SizedBox(height: height * 0.015),
          _buildInput(
            _phoneController,
            Icons.phone,
            'Numéro de téléphone',
            textColor1,
            textFieldColor,
            _phoneError,
          ),
          SizedBox(height: height * 0.015),
          _buildDatePickerField(
            'Date de naissance',
            _birthDateController,
            context, // ✅ ici
            textColor1,
            textFieldColor,
            _naissanceError,
            isDarkMode,
          ),
          SizedBox(height: height * 0.015),

          Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value ?? false;
                  });
                },
                activeColor: kPrimaryRed,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                ConfidentialiyPage(), // Remplacez par votre page de conditions
                      ),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: textColor1),
                      children: [
                        TextSpan(text: 'Accepter les '),
                        TextSpan(
                          text: 'termes & politiques de confidentialité.',
                          style: TextStyle(
                            color: kPrimaryRed,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          

          Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: width * 0.5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(20.0),
                  backgroundColor: kPrimaryRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  if (_isFormValid()) {
                    print("Valide");

                    _OnConfirm();
                  } else {
                    print("non valide");
                  }
                },
                child: Text(
                  'S’inscrire',
                  style: TextStyle(fontSize: 16, color: kPrimaryWhite),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width * 0.57,

                child: AutoSizeText(
                  "Vous possédez deja un compte ?",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textColor1,
                  ),
                  maxFontSize: 15,
                  minFontSize: 10,
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: SizedBox(
                  width: width * 0.26,
                  child: AutoSizeText(
                    "Se connecter",
                    style: TextStyle(
                      color: kPrimaryRed,

                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    maxFontSize: 16,
                    minFontSize: 13,
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildInput(
  TextEditingController controller,
  IconData icon,
  String hint,
  Color textColor1,
  textFieldColor,
  String? errorText,
) {
  return TextField(
    controller: controller,
    style: TextStyle(color: textColor1),
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: textColor1),
      hintText: hint,
      hintStyle: TextStyle(color: textColor1),
      filled: true,
      fillColor: textFieldColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      errorText: errorText, // ✅ ici
    ),
  );
}

Widget _buildDatePickerField(
  String labelText,
  TextEditingController controller,
  context,
  Color textColor,
  Color textFieldColor,
  String? errorMessage,
  bool isDarkMode,
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
        
        child: GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              builder: (context, child) {
                return Theme(
                  data: isDarkMode ? ThemeData.dark() : ThemeData.light(),
                  child: child!,
                );
              },
            );

            if (pickedDate != null) {
              String formattedDate =
                  "${pickedDate.year.toString().padLeft(4, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
              controller.text = formattedDate;
            }
          },

          child: TextField(
            controller: controller,
            enabled: false,
            decoration: InputDecoration(
              fillColor: textFieldColor,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              hintText: "aaaa-mm-jj",
            ),
            style: TextStyle(color: textColor),
          ),
        ),
      ),
      if (errorMessage != null) ...[
        SizedBox(height: height * 0.01),
        Text(errorMessage, style: TextStyle(color: kPrimaryRed, fontSize: 12)),
      ],
       
    ],
  );
}
