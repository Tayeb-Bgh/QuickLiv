import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobileapp/features/auth/presentation/providers/auth_provider.dart';
import 'package:mobileapp/features/customer/gesProfil/DevLivreur/business/entities/deliverer.dart';
import 'package:mobileapp/features/customer/gesProfil/DevLivreur/data/models/deliverer_model.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

class DelivererService {
  final Dio dio;
  final WidgetRef ref;

  DelivererService(this.dio, this.ref);

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
        print('Erreur: ${response.statusCode} - ${response.body}');
        throw Exception('Échec de l\'enregistrement du livreur');
      }
    } catch (e) {
      print('Erreur lors de l\'enregistrement du livreur : $e');
      throw Exception('Erreur lors de l\'enregistrement du livreur');
    }
  }

  Future<void> updateSubmitedClient() async {
    try {
      final url = await ApiConfig.getBaseUrl();
      final token = await ref.read(jwtTokenProvider.future);

      final response = await dio.put(
        '$url/gesProfil/update-client-submited',
        data: {'isSubmittedDelivererCust': 1},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.data['success'] != true) {
        throw Exception(
          response.data['message'] ?? 'Failed to update client status',
        );
      }
    } catch (e) {
      print('Error when updating client: $e');
      throw Exception('Failed to update client status: $e');
    }
  }
}
