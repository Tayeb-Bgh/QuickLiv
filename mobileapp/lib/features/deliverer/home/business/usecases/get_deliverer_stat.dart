import 'package:mobileapp/features/deliverer/home/business/entities/deliverer_status_entity.dart';
import 'package:mobileapp/features/deliverer/home/business/repositories/deliverer_home_repo.dart';

class GetDelivererStat {
  final DelivererHomeRepo repository;

  GetDelivererStat(this.repository);

  Future<DelivererStatusEntity> call() async {
    return await repository.getDelivererData();
  }
}
