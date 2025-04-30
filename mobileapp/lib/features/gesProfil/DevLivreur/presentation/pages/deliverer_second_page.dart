import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/features/gesProfil/DevLivreur/business/usercases/validate_deliverer_usecase.dart';
import 'package:mobileapp/features/gesProfil/DevLivreur/presentation/providers/form_data_provider.dart';
import 'package:mobileapp/features/gesProfil/DevLivreur/presentation/widgets/gender_selection_widget.dart';
import 'package:mobileapp/features/gesProfil/DevLivreur/presentation/widgets/type_selection_widget.dart';
import 'package:mobileapp/features/gesProfil/DevLivreur/presentation/widgets/year_picker_dialog.dart';

class DelivererSecondPage extends ConsumerStatefulWidget {
  const DelivererSecondPage({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  @override
  ConsumerState<DelivererSecondPage> createState() =>
      _DelivererSecondPageState();
}

class _DelivererSecondPageState extends ConsumerState<DelivererSecondPage> {
  String? _selectedValue;

  final TextEditingController marqueController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController anneeController = TextEditingController();
  final TextEditingController couleurController = TextEditingController();
  final TextEditingController matriculeController = TextEditingController();
  final TextEditingController chassisController = TextEditingController();
  final TextEditingController assuranceController = TextEditingController();

  void _updateFormData() {
    final formData = ref.read(formDataProvider.notifier);
    formData.updateField('marque', marqueController.text);
    formData.updateField('model', modelController.text);
    formData.updateField('annee', anneeController.text);
    formData.updateField('couleur', couleurController.text);
    formData.updateField('matricule', matriculeController.text);
    formData.updateField('numChassis', chassisController.text);
    formData.updateField('assurance', assuranceController.text);
    formData.updateField('type', _selectedValue ?? '');
  }

  final Validatedeliverer validator = Validatedeliverer();

  String? _marqueError;
  String? _modelError;
  String? _anneeError;
  String? _couleurError;
  String? _matriculeError;
  String? _chassisError;
  String? _assuranceError;
  String? _sexeError;

  bool _isFormValid() {
    bool isValid = true;

    if (marqueController.text.isEmpty) {
      isValid = false;
      setState(() {
        _marqueError = "Veuillez remplir ce champ.";
      });
    } else {
      setState(() {
        _marqueError = null;
      });
    }

    if (modelController.text.isEmpty) {
      isValid = false;
      setState(() {
        _modelError = "Veuillez remplir ce champ.";
      });
    } else {
      setState(() {
        _modelError = null;
      });
    }

    if (anneeController.text.isEmpty) {
      isValid = false;
      setState(() {
        _anneeError = "Veuillez remplir ce champ.";
      });
    } else {
      setState(() {
        _anneeError = null;
      });
    }

    if (couleurController.text.isEmpty) {
      isValid = false;
      setState(() {
        _couleurError = "Veuillez remplir ce champ.";
      });
    } else {
      setState(() {
        _couleurError = null;
      });
    }

    if (matriculeController.text.isEmpty) {
      isValid = false;
      setState(() {
        _matriculeError = "Veuillez remplir ce champ.";
      });
    } else {
      setState(() {
        _matriculeError = null;
      });
    }

    if (chassisController.text.isEmpty) {
      isValid = false;
      setState(() {
        _chassisError = "Veuillez remplir ce champ.";
      });
    } else {
      setState(() {
        _chassisError = null;
      });
    }

    if (assuranceController.text.isEmpty ||
        !validator.validateDateNais(assuranceController.text)) {
      isValid = false;
      setState(() {
        _assuranceError = "Veuillez remplir ce champ.";
      });
    } else {
      setState(() {
        _assuranceError = null;
      });
    }

    if (_selectedValue == null) {
      isValid = false;
      setState(() {
        _sexeError = "Veuillez sélectionner le type.";
      });
    } else {
      setState(() {
        _sexeError = null;
      });
    }

    return isValid;
  }

  void _openYearPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return YearPickerDialog(
          onYearSelected: (selectedYear) {
            setState(() {
              anneeController.text = selectedYear.toString();
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final isDarkMode = ref.watch(darkModeProvider);

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
                          decoration: BoxDecoration(color: Colors.redAccent),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.redAccent,
                          radius: 17,
                          child: AutoSizeText(
                            '2',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.white,
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
                      'Informations sur le Véhicule',
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    _buildTextField(
                      "Marque:",
                      marqueController,
                      context,
                      textColor,
                      textFieldColor,
                      _marqueError,
                    ),
                    _buildTextField(
                      "Modele:",
                      modelController,
                      context,
                      textColor,
                      textFieldColor,
                      _modelError,
                    ),
                    _buildYearPickerField(
                      "Année:",
                      anneeController,
                      context,
                      textColor,
                      textFieldColor,
                      _anneeError,
                    ),
                    _buildTextField(
                      "Couleur:",
                      couleurController,
                      context,
                      textColor,
                      textFieldColor,
                      _couleurError,
                    ),
                    _buildTextField(
                      "Matricule:",
                      matriculeController,
                      context,
                      textColor,
                      textFieldColor,
                      _matriculeError,
                    ),
                    _buildTextField(
                      "Numéro de Chassis:",
                      chassisController,
                      context,
                      textColor,
                      textFieldColor,
                      _chassisError,
                    ),
                    _buildDatePickerField(
                      "Date expiration de l'assurance :",
                      assuranceController,
                      context,
                      textColor,
                      textFieldColor,
                      _assuranceError,
                    ),
                    TypeSelectionRow(
                      selectedValue: _selectedValue,
                      onValueSelected: (value) {
                        setState(() {
                          _selectedValue = value;
                          print(_selectedValue);
                        });
                      },
                    ),
                    if (_sexeError != null) ...[
                      SizedBox(height: 8),
                      Text(
                        _sexeError!,
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ],
                  ],
                ),
              ),
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
                          backgroundColor: Color(0xFF504E4E),
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
                            color: Colors.white,
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
          child: TextField(
            controller: controller,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              fillColor: textFieldColor,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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

  Widget _buildYearPickerField(
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
            onTap: () {
              _openYearPicker(context);
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
              DateTime currentDate = DateTime.now();
              DateTime lastSelectableDate = currentDate.add(
                Duration(days: 365 * 10), //10ans apr
              );

              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: currentDate,
                firstDate: DateTime(1900),
                lastDate: lastSelectableDate,
                builder: (context, child) {
                  return Theme(
                    data: isDarkMode ? ThemeData.dark() : ThemeData.light(),
                    child: child!,
                  );
                },
              );

              if (pickedDate != null) {
                // Format the selected date as yyyy-MM-dd
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
                hintText: "aaaa-mm-jj", // Display format as a hint
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
