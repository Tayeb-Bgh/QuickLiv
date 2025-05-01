import 'package:mobileapp/features/gesProfil/DevCommercant/business/entities/trader.dart';

abstract class TraderRepository {
  Future<void> saveTrader(Trader trader);
}
