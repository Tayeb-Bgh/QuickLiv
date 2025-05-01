import 'package:mobileapp/features/customer/gesProfil/DevLivreur/business/entities/deliverer.dart';
import 'package:mobileapp/features/customer/gesProfil/DevLivreur/business/repositories/deliverer_repository.dart';

class SaveDelivererUsecase {
  final DelivererRepository repository;

  SaveDelivererUsecase({required this.repository});

  Future<void> execute(Deliverer deliverer) async {
    try {
      await repository.saveDeliverer(deliverer);
    } catch (e) {

      print('Erreur lors de la sauvegarde du livreur : $e');
      throw Exception('Échec de l\'enregistrement du livreur');
    }
  }
}
