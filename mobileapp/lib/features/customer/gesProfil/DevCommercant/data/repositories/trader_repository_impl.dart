import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/auth/presentation/providers/auth_provider.dart';
import 'package:mobileapp/features/customer/gesProfil/DevCommercant/business/entities/trader.dart';
import 'package:mobileapp/features/customer/gesProfil/DevCommercant/business/repositories/trader_repository.dart';
import 'package:mobileapp/features/customer/gesProfil/DevCommercant/data/models/trader_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

class TraderRepositoryImpl implements TraderRepository {
  final Dio dio;
  final WidgetRef ref;

  TraderRepositoryImpl(this.dio, this.ref);

  @override
  Future<void> saveTrader(Trader trader) async {
    final String url = await ApiConfig.getBaseUrl();
    final String apiUrl = '$url/gesProfil//createTrader';
    print("API URL: $apiUrl");

    try {
      final TraderModel traderModel = TraderModel(
        nom: trader.nom,
        prenom: trader.prenom,
        dateNais: trader.dateNais,
        adresse: trader.adresse,
        telephone: trader.telephone,
        numIdentite: trader.numIdentite,
        sexe: trader.sexe,
        nomCommerce: trader.nomCommerce,
        adresseCommerce: trader.adresseCommerce,
        telephoneCommerce: trader.telephoneCommerce,
        email: trader.email,
        numRegCommerce: trader.numRegCommerce,
        type: trader.type,
        pieceIdentit: trader.pieceIdentit,
        regCommerce: trader.regCommerce,
        paieImpots: trader.paieImpots,
        autoSanitaire: trader.autoSanitaire,
      );

      final Map<String, dynamic> traderJson = traderModel.toJson();
      print('|||||||||||||||||||||||| $traderJson');

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(traderJson),
      );

      if (response.statusCode == 201) {
        print('commerce créé avec succès');
      } else {
        print('Erreur: ${response.statusCode} - ${response.body}');
        throw Exception('Échec de l\'enregistrement du commerce');
      }
    } catch (e) {
      print('Erreur lors de l\'enregistrement du commerce : $e');
      throw Exception('Erreur lors de l\'enregistrement du commerce');
    }
  }

  @override
  Future<void> updateSubmitedClient() async {
    try {
      final url = await ApiConfig.getBaseUrl();
      final token = await ref.read(jwtTokenProvider.future);

      final response = await dio.put(
        '$url/gesProfil/update-client',
        data: {'isSubmittedPartnerCust': 1},
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
