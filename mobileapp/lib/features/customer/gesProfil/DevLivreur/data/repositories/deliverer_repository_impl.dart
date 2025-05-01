import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobileapp/features/customer/gesProfil/DevLivreur/business/entities/deliverer.dart';
import 'package:mobileapp/features/customer/gesProfil/DevLivreur/business/repositories/deliverer_repository.dart';
import 'package:mobileapp/features/customer/gesProfil/DevLivreur/data/models/deliverer_model.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';

class DelivererRepositoryImpl implements DelivererRepository {
  @override
  Future<void> saveDeliverer(Deliverer deliverer) async {
    final String url = await ApiConfig.getBaseUrl();
    final String apiUrl = '$url/gesProfil/createdeliverer';
    print("API URL: $apiUrl");

    try {
      final DelivererModel delivererModel = DelivererModel(
        nom: deliverer.nom,
        prenom: deliverer.prenom,
        dateNais: deliverer.dateNais,
        adresse: deliverer.adresse,
        telephone: deliverer.telephone,
        email: deliverer.email,
        numSecuriteSociale: deliverer.numSecuriteSociale,
        numPermis: deliverer.numPermis,
        sexe: deliverer.sexe,
        marque: deliverer.marque,
        model: deliverer.model,
        annee: deliverer.annee,
        couleur: deliverer.couleur,
        matricule: deliverer.matricule,
        numChassis: deliverer.numChassis,
        assurance: deliverer.assurance,
        type: deliverer.type,
        photoIdent: deliverer.photoIdent,
        photoVehic: deliverer.photoVehic,
        permis: deliverer.permis,
        carteGrise: deliverer.carteGrise,
      );

      final Map<String, dynamic> delivererJson = delivererModel.toJson();

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(delivererJson),
      );

      if (response.statusCode == 201) {
        print('Deliverer créé avec succès');
      } else {
        print(
          'Erreur: ${response.statusCode} - ${response.body}',
        );
        throw Exception('Échec de l\'enregistrement du livreur');
      }
    } catch (e) {
      print('Erreur lors de l\'enregistrement du livreur : $e');
      throw Exception('Erreur lors de l\'enregistrement du livreur');
    }
  }
}
