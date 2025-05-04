import 'package:mobileapp/features/customer/gesProfil/DevCommercant/business/entities/trader.dart';

abstract class TraderRepository {
  Future<void> saveTrader(Trader trader);
}
