import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/gesProfil/DevLivreur/business/entities/deliverer.dart';
import 'package:mobileapp/features/gesProfil/DevLivreur/business/usercases/save_deliverer_usecase.dart';
import 'package:mobileapp/features/gesProfil/DevLivreur/data/repositories/deliverer_repository_impl.dart';
import 'package:mobileapp/features/gesProfil/DevLivreur/data/service/file_picker.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'dart:io';

import 'package:mobileapp/features/gesProfil/DevLivreur/business/usercases/validate_deliverer_usecase.dart';
import 'package:mobileapp/features/gesProfil/DevLivreur/presentation/providers/form_data_provider.dart';

class DelivererThirdPage extends ConsumerStatefulWidget {
  const DelivererThirdPage({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  final VoidCallback onNext;
  final VoidCallback onPrevious;

  @override
  ConsumerState<DelivererThirdPage> createState() => _DelivererThirdPageState();
}

class _DelivererThirdPageState extends ConsumerState<DelivererThirdPage> {
  String? _photoIdentite;
  String? _photoVehicule;
  String? _permisConduire;
  String? _carteGrise;

  final Filepicker _filePickerUseCase = Filepicker();
  final Validatedeliverer _validator = Validatedeliverer();

  @override
  void initState() {
    super.initState();
    final formData = ref.read(formDataProvider);
    _photoIdentite = formData['photoIdentite'];
    _photoVehicule = formData['photoVehicule'];
    _permisConduire = formData['permisConduire'];
    _carteGrise = formData['carteGrise'];
  }

  void _updateFormData() {
    final formData = ref.read(formDataProvider.notifier);

    formData.updateField('photoIdentite', _photoIdentite ?? '');
    formData.updateField('photoVehicule', _photoVehicule ?? '');
    formData.updateField('permisConduire', _permisConduire ?? '');
    formData.updateField('carteGrise', _carteGrise ?? '');
  }

  Future<void> _pickFile(String field) async {
    String? filePath = await _filePickerUseCase.pickFile();

    if (filePath != null) {
      setState(() {
        if (field == 'PhotoIdentite') {
          _photoIdentite = filePath;
        } else if (field == 'PhotoVehicule') {
          _photoVehicule = filePath;
        } else if (field == 'PermisConduire') {
          _permisConduire = filePath;
        } else if (field == 'CarteGrise') {
          _carteGrise = filePath;
        }
        _updateFormData();
      });
    }
  }

  bool _areDocumentsValid() {
    return _validator.validateDocuments(
      photoIdentite: _photoIdentite,
      photoVehicule: _photoVehicule,
      permisConduire: _permisConduire,
      carteGrise: _carteGrise,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final isDarkMode = ref.watch(darkModeProvider);

    final Color backColor = isDarkMode ? Color(0xFF282525) : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color buttonColor =
        isDarkMode ? Color(0xFF363333) : Color(0xFFD9D9D9);

    return Scaffold(
      backgroundColor: backColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.09,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          decoration: BoxDecoration(color: Colors.redAccent),
                        ),
                        CircleAvatar(
                          radius: 17,
                          backgroundColor: Colors.redAccent,
                          child: AutoSizeText(
                            '3',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    AutoSizeText(
                      'Joindre des documents',
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'roboto',
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDocumentField(
                      "Piece d'identité:",
                      'PhotoIdentite',
                      textColor,
                      buttonColor,
                      _photoIdentite,
                    ),
                    _buildDocumentField(
                      "Photo du véhicule:",
                      'PhotoVehicule',
                      textColor,
                      buttonColor,
                      _photoVehicule,
                    ),
                    _buildDocumentField(
                      "Permis de conduire:",
                      'PermisConduire',
                      textColor,
                      buttonColor,
                      _permisConduire,
                    ),
                    _buildDocumentField(
                      "Carte grise / Papier de vente:",
                      'CarteGrise',
                      textColor,
                      buttonColor,
                      _carteGrise,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_photoIdentite != null && _photoIdentite!.isNotEmpty)
                      _buildImagePreview('Photo d\'identité', _photoIdentite),
                    if (_photoVehicule != null && _photoVehicule!.isNotEmpty)
                      _buildImagePreview('Photo du véhicule', _photoVehicule),
                    if (_permisConduire != null && _permisConduire!.isNotEmpty)
                      _buildImagePreview('Permis de conduire', _permisConduire),
                    if (_carteGrise != null && _carteGrise!.isNotEmpty)
                      _buildImagePreview(
                        'Carte grise / Papier de vente',
                        _carteGrise,
                      ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.1),
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
                        onPressed: () async {
                          if (_areDocumentsValid()) {
                            final formData = ref.watch(formDataProvider);
                            final deliverer = Deliverer(
                              nom: formData['nom'] ?? '',
                              prenom: formData['prenom'] ?? '',
                              dateNais: formData['naissance'] ?? '',
                              adresse: formData['adresse'] ?? '',
                              telephone: formData['telephone'] ?? '',
                              email: formData['email'] ?? '',
                              numSecuriteSociale:
                                  formData['numSecuriteSociale'] ?? '',
                              numPermis: formData['numPermis'] ?? '',
                              sexe: formData['sexe'] ?? '',
                              marque: formData['marque'] ?? '',
                              model: formData['model'] ?? '',
                              annee: formData['annee'] ?? '',
                              couleur: formData['couleur'] ?? '',
                              matricule: formData['matricule'] ?? '',
                              numChassis: formData['numChassis'] ?? '',
                              assurance: formData['assurance'] ?? '',
                              type: formData['type'] ?? '',
                              photoIdent: _photoIdentite ?? '',
                              photoVehic: _photoVehicule ?? '',
                              permis: _permisConduire ?? '',
                              carteGrise: _carteGrise ?? '',
                            );

                            final usecase = SaveDelivererUsecase(
                              repository: DelivererRepositoryImpl(),
                            );

                            try {
                              await usecase.execute(deliverer);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Livreur enregistré avec succès!',
                                  ),
                                ),
                              );

                              widget.onNext();
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Erreur lors de l\'enregistrement',
                                  ),
                                ),
                              );
                            }
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
                          'Confirmer',
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

  Widget _buildDocumentField(
    String labelText,
    String field,
    Color textColor,
    Color buttonColor,
    String? documentPath,
  ) {

    bool isDocumentSelected = documentPath != null && documentPath.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
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
          SizedBox(
            width: 100,
            height: 30,
            child: ElevatedButton(
              onPressed: () => _pickFile(field),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isDocumentSelected
                        ? const Color.fromARGB(255, 253, 77, 77)
                        : buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              ),
              child: AutoSizeText(
                isDocumentSelected
                    ? 'Modifier'
                    : '+ Joindre',
                style: TextStyle(
                  fontSize: 13,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Méthode pour afficher l'image sélectionnée sous les boutons
  Widget _buildImagePreview(String label, String? imagePath) {
    final isDarkMode = ref.watch(darkModeProvider);
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
          ),
          SizedBox(height: 10),
          Image.file(
            File(imagePath!),
            width: 250,
            height: 100,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
