import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/customer/gesProfil/DevCommercant/business/entities/trader.dart';

import 'package:mobileapp/features/customer/gesProfil/DevCommercant/business/usercases/save_trader_usercase.dart';
import 'package:mobileapp/features/customer/gesProfil/DevCommercant/business/usercases/validateTrader.dart';
import 'package:mobileapp/features/customer/gesProfil/DevCommercant/data/repositories/trader_repository_impl.dart';
import 'package:mobileapp/features/customer/gesProfil/DevCommercant/data/service/FilePicker.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'dart:io';

import 'package:mobileapp/features/customer/gesProfil/DevCommercant/presentation/providers/from_data_provider.dart';

class TraderThirdPage extends ConsumerStatefulWidget {
  const TraderThirdPage({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  final VoidCallback onNext;
  final VoidCallback onPrevious;

  @override
  ConsumerState<TraderThirdPage> createState() => _DelivererThirdPageState();
}

class _DelivererThirdPageState extends ConsumerState<TraderThirdPage> {
  String? _selectedValue;
  String? _pieceIdentit;
  String? _regCommerce;
  String? _paieImpots;
  String? _autoSanitaire;

  final Filepicker _filePickerUseCase = Filepicker();

  final Validatetrader _validator = Validatetrader();

  @override
  void initState() {
    super.initState();
    final formData = ref.read(formDataProvider);
    _pieceIdentit = formData['pieceIdentit'];
    _regCommerce = formData['regCommerce'];
    _paieImpots = formData['paieImpots'];
    _autoSanitaire = formData['autoSanitaire'];
    _selectedValue = formData['type'];
  }

  void _updateFormData() {
  final formData = ref.read(formDataProvider.notifier);

  formData.updateField('pieceIdentit', _pieceIdentit ?? ''); 
  formData.updateField('regCommerce', _regCommerce ?? '');
  formData.updateField('paieImpots', _paieImpots ?? '');
  formData.updateField('autoSanitaire', _autoSanitaire ?? '');
}

  Future<void> _pickFile(String field) async {
    String? filePath = await _filePickerUseCase.pickFile();

    if (filePath != null) {
      setState(() {
        if (field == 'pieceIdentit') {
          _pieceIdentit = filePath;
        } else if (field == 'regCommerce') {
          _regCommerce = filePath;
        } else if (field == 'paieImpots') {
          _paieImpots = filePath;
        } else if (field == 'autoSanitaire') {
          _autoSanitaire = filePath;
        }
      });

      final formData = ref.read(formDataProvider.notifier);
      formData.updateField(field, filePath);
    }
  }

  // Vérifie si tous les documents sont joints
  bool _areDocumentsValid() {
    return _validator.validateDocuments(
      pieceIdentit: _pieceIdentit,
      regCommerce: _regCommerce,
      paieImpots: _paieImpots,
      autoSanitaire: _autoSanitaire,
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
                      "Pièce d’Identité:",
                      'pieceIdentit',
                      textColor,
                      buttonColor,
                      _pieceIdentit,
                    ),
                    _buildDocumentField(
                      "Registre de Commerce:",
                      'regCommerce',
                      textColor,
                      buttonColor,
                      _regCommerce,
                    ),
                    _buildDocumentField(
                      "Déclaration de Paiement d’Impôts:",
                      'paieImpots',
                      textColor,
                      buttonColor,
                      _paieImpots,
                    ),
                    _buildDocumentField(
                      "Autorisation Sanitaire:",
                      'autoSanitaire',
                      textColor,
                      buttonColor,
                      _autoSanitaire,
                    ),
                  ],
                ),
              ),
              // Affichage des images sous les boutons Joindre
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_pieceIdentit != null && _pieceIdentit!.isNotEmpty)
                      _buildImagePreview('Pièce d’Identité', _pieceIdentit),
                    if (_regCommerce != null && _regCommerce!.isNotEmpty)
                      _buildImagePreview('Registre de Commerce', _regCommerce),
                    if (_paieImpots != null && _paieImpots!.isNotEmpty)
                      _buildImagePreview(
                        'Déclaration de Paiement d’Impôts',
                        _paieImpots,
                      ),
                    if (_autoSanitaire != null && _autoSanitaire!.isNotEmpty)
                      _buildImagePreview(
                        'Autorisation Sanitaire',
                        _autoSanitaire,
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
                            final trader = Trader(
                              nom: formData['nom'] ?? '',
                              prenom: formData['prenom'] ?? '',
                              dateNais: formData['naissance'] ?? '',
                              adresse: formData['adresse'] ?? '',
                              telephone: formData['telephone'] ?? '',
                              numIdentite: formData['numIdentite'] ?? '',
                              sexe: formData['sexe'] ?? '',
                              nomCommerce: formData['nomCommerce'] ?? '',
                              adresseCommerce:
                                  formData['adresseCommerce'] ?? '',
                              telephoneCommerce:
                                  formData['telephoneCommerce'] ?? '',
                              email: formData['email'] ?? '',
                              numRegCommerce: formData['numRegCommerce'] ?? '',
                              type: formData['type'] ?? '',
                              pieceIdentit: _pieceIdentit ?? '',
                              regCommerce: _regCommerce ?? '',
                              paieImpots: _paieImpots ?? '',
                              autoSanitaire: _autoSanitaire ?? '',
                            );
                            final usecase = SaveTraderUsercase(
                              repository: TraderRepositoryImpl(),
                            );

                            try {
                              await usecase.execute(trader);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Commerce enregistré avec succès!',
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
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Veuillez télécharger tous les documents.",
                                ),
                              ),
                            );
                          }
                        }, // Désactive le bouton si les documents ne sont pas validés
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

  Widget _buildImagePreview(String label, String? imagePath) {
    final isDarkMode = ref.watch(darkModeProvider);
    final Color textColor = isDarkMode ? Colors.white : Colors.black;

    if (imagePath == null || imagePath.isEmpty) {
      return SizedBox.shrink(); 
    }

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
            File(imagePath),
            width: 250,
            height: 100,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
