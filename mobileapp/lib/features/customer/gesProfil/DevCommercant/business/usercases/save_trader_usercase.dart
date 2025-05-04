import 'package:mobileapp/features/customer/gesProfil/DevCommercant/business/entities/trader.dart';
import 'package:mobileapp/features/customer/gesProfil/DevCommercant/business/repositories/trader_repository.dart';

class SaveTraderUsercase {
  final TraderRepository repository;

  SaveTraderUsercase({required this.repository});

  Future<void> execute(Trader trader) async {
    try {
      await repository.saveTrader(trader);
    } catch (e) {
      print('Erreur lors de la sauvegarde du commerce : $e');
      throw Exception('Échec de l\'enregistrement du commerce');
    }
  }
}
