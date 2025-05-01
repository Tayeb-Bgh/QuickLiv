import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/customer/gesProfil/DevCommercant/business/entities/trader.dart';
import 'package:mobileapp/features/customer/gesProfil/DevCommercant/business/repositories/trader_repository.dart';
import 'package:mobileapp/features/customer/gesProfil/DevCommercant/data/models/trader_model.dart';

class TraderRepositoryImpl implements TraderRepository {
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
            print(
        '|||||||||||||||||||||||| $traderJson',
      );

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
}
