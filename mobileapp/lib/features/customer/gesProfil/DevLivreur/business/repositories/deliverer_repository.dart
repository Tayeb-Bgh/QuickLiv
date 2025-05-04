import 'package:mobileapp/features/customer/gesProfil/DevLivreur/business/entities/deliverer.dart';

abstract class DelivererRepository {
  Future<void> saveDeliverer(Deliverer deliverer);
  Future<void> updateSubmitedClient();
}
