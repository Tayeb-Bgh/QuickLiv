import 'package:mobileapp/features/gesProfil/DevLivreur/business/entities/deliverer.dart';

abstract class DelivererRepository {
  Future<void> saveDeliverer(Deliverer deliverer);
}
