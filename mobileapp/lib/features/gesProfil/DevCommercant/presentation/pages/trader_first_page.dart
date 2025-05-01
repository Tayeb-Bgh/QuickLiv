import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/features/gesProfil/DevCommercant/business/usercases/validateTrader.dart';
import 'package:mobileapp/features/gesProfil/DevCommercant/presentation/providers/from_data_provider.dart';
import 'package:mobileapp/features/gesProfil/DevLivreur/presentation/widgets/gender_selection_widget.dart';

class TradeFirstPage extends ConsumerStatefulWidget {
  const TradeFirstPage({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  _TradeFirstPageState createState() => _TradeFirstPageState();
}

class _TradeFirstPageState extends ConsumerState<TradeFirstPage> {
  String? _selectedValue;
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController naissanceController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();
  final TextEditingController telController = TextEditingController();
  final TextEditingController numIdentiteController = TextEditingController();

  final Validatetrader validator = Validatetrader();

  @override
  void initState() {
    super.initState();
    final formData = ref.read(formDataProvider);
    nomController.text = formData['nom'] ?? '';
    prenomController.text = formData['prenom'] ?? '';
    naissanceController.text = formData['naissance'] ?? '';
    adresseController.text = formData['adresse'] ?? '';
    telController.text = formData['telephone'] ?? '';
    numIdentiteController.text = formData['numIdentite'] ?? '';
    _selectedValue = formData['sexe'];
  }

  void _updateFormData() {
    final formData = ref.read(formDataProvider.notifier);
    formData.updateField('nom', nomController.text);
    formData.updateField('prenom', prenomController.text);
    formData.updateField('naissance', naissanceController.text);
    formData.updateField('adresse', adresseController.text);
    formData.updateField('telephone', telController.text);
    formData.updateField('numIdentite', numIdentiteController.text);
    formData.updateField('sexe', _selectedValue ?? '');
  }

  String? _nomError;
  String? _prenomError;
  String? _naissanceError;
  String? _adresseError;
  String? _telError;
  String? _numIdentiteError;
  String? _sexeError;

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

    if (prenomController.text.isEmpty) {
      isValid = false;
      setState(() {
        _prenomError = "Veuillez remplir ce champ.";
      });
    } else {
      setState(() {
        _prenomError = null;
      });
    }

    if (naissanceController.text.isEmpty ||
        !validator.validateDateNais(naissanceController.text)) {
      isValid = false;
      setState(() {
        _naissanceError = "Veuillez remplir ce champ correctement.";
      });
    } else {
      setState(() {
        _naissanceError = null;
      });
    }

    if (adresseController.text.isEmpty ) {
      isValid = false;
      setState(() {
        _adresseError = "Veuillez remplir ce champ.";
      });
    } else {
      setState(() {
        _adresseError = null;
      });
    }

    if (telController.text.isEmpty || !validator.validatePhoneNumber(telController.text)) {
      isValid = false;
      setState(() {
        _telError = "Veuillez remplir ce champ correctement.";
      });
    } else {
      setState(() {
        _telError = null;
      });
    }

    if (numIdentiteController.text.isEmpty) {
      isValid = false;
      setState(() {
        _numIdentiteError = "Veuillez remplir ce champ.";
      });
    } else {
      setState(() {
        _numIdentiteError = null;
      });
    }

    if (_selectedValue == null) {
      isValid = false;
      setState(() {
        _sexeError = "Veuillez sélectionner votre sexe.";
      });
    } else {
      setState(() {
        _sexeError = null;
      });
    }

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final bool isDarkMode = ref.watch(darkModeProvider);

    final Color backColor = isDarkMode ? Color(0xFF282525) : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color textFieldColor =
        isDarkMode ? Color(0xFF363333) : Color(0xFFCCCCCC);
    final Color circleColor =
        isDarkMode ? Color(0xFF363333) : Color(0xFFD9D9D9);

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
                          backgroundColor: Colors.redAccent,
                          radius: 17,
                          child: AutoSizeText(
                            '1',
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
                        Container(
                          width: width * 0.2,
                          height: height * 0.006,
                          decoration: BoxDecoration(color: circleColor),
                        ),
                        CircleAvatar(
                          backgroundColor: circleColor,
                          radius: 17,
                          child: AutoSizeText(
                            '2',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: textColor,
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
                    AutoSizeText(
                      'Informations Personnelles',
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
                      "Prénom:",
                      prenomController,
                      context,
                      textColor,
                      textFieldColor,
                      _prenomError,
                    ),
                    _buildDatePickerField(
                      "Date de Naissance:",
                      naissanceController,
                      context,
                      textColor,
                      textFieldColor,
                      _naissanceError,
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
                      "Téléphone :",
                      telController,
                      context,
                      textColor,
                      textFieldColor,
                      _telError,
                    ),
                    _buildTextField(
                      "Numéro de Pièce d’Identité :",
                      numIdentiteController,
                      context,
                      textColor,
                      textFieldColor,
                      _numIdentiteError,
                    ),
                    GenderSelectionRow(
                      selectedValue: _selectedValue,
                      onValueSelected: (value) {
                        setState(() {
                          _selectedValue = value;
                          print(_selectedValue);
                        });
                      },
                    ),
                    if (_sexeError != null)
                      Text(
                        _sexeError!,
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: width * 0.4,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_isFormValid()) {
                            _updateFormData();
                            widget.onNext();
                          }else {}
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
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
                            color: Colors.white,
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
    context,
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
                color: Colors.red, // Red asterisk
                fontSize: 20,
              ),
            ),
            SizedBox(width: 5), // Space between the asterisk and the label
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
          Text(errorMessage, style: TextStyle(color: Colors.red, fontSize: 12)),
        ],
        SizedBox(height: height * 0.02),
      ],
    );
  }

  Widget _buildDatePickerField(
    String labelText,
    TextEditingController controller,
    context,
    Color textColor,
    Color textFieldColor,
    String? errorMessage,
  ) {
    final height = MediaQuery.of(context).size.height;
    final bool isDarkMode = ref.watch(darkModeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "*",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
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
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 10,
                ),
                hintText: "aaaa-mm-jj",
              ),
              style: TextStyle(color: textColor),
            ),
          ),
        ),
        if (errorMessage != null) ...[
          SizedBox(height: height * 0.01),
          Text(errorMessage, style: TextStyle(color: Colors.red, fontSize: 12)),
        ],
        SizedBox(height: height * 0.02),
      ],
    );
  }
}
