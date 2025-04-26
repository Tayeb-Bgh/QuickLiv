import 'package:mobileapp/features/deliverer/home/business/entities/deliverer_status_entity.dart';
import 'package:mobileapp/features/deliverer/home/business/repositories/deliverer_home_repo.dart';
import 'package:mobileapp/features/deliverer/home/data/models/deliverer_status_model.dart';
import 'package:mobileapp/features/deliverer/home/data/service/deliverer_home_service.dart';

class DelivererHomeRepoImpl implements DelivererHomeRepo {
  final DelivererHomeService delivererHomeService;

  DelivererHomeRepoImpl(this.delivererHomeService);
  @override
  Future<DelivererStatusEntity> getDelivererData() async {
    try {
      final DelivererStatusModel delivererStatusModel =
          await delivererHomeService.getDelivererInfo();

      return delivererStatusModel.toEntity();
    } catch (e) {
      print("Error in DelivererHomeRepoImpl: $e");
      rethrow;
    }
  }
}
