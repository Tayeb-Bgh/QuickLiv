import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/auth/presentation/providers/auth_provider.dart';

class DelivererService {
  final Dio dio;
  final Ref ref;

  DelivererService(this.dio, this.ref);

  Future<void> updateSubmitedClient() async {
    try {
      final url = await ApiConfig.getBaseUrl();
      final token = await ref.read(jwtTokenProvider.future); // Récupérer le token d'authentification

      final response = await dio.put(
        '$url/gesProfil/update-client-submited',  // URL de l'API pour la mise à jour du client
        data: {
          'pointsCust': 1, // L'attribut à mettre à jour
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),  // Authentification avec le token
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        print('Client mis à jour avec succès');
      } else {
        throw Exception(
          response.data['message'] ?? 'Échec de la mise à jour du client',
        );
      }
    } catch (e) {
      print('Erreur lors de la mise à jour du client : $e');
      throw Exception('Échec de la mise à jour du client');
    }
  }
}

