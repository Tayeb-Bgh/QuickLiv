import 'package:mobileapp/features/deliverer/home/business/entities/deliverer_status_entity.dart';

abstract class DelivererHomeRepo {
  Future<DelivererStatusEntity> getDelivererData();
}
