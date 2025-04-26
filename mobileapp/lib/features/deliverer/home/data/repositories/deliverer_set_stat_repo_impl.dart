import 'package:mobileapp/features/deliverer/home/business/repositories/deliverer_set_stat_repo.dart';
import '../service/deliverer_home_service.dart';

class DelivererSetStatRepoImpl implements DelivererSetStatRepo {
  final DelivererHomeService delivererHomeService;

  DelivererSetStatRepoImpl(this.delivererHomeService);

  @override
  Future<void> changeDelivererStatus(bool status) async {
    try {
      final result = await delivererHomeService.setAvaibility(status);
      if (!result) {
        throw Exception("Failed to update deliverer status");
      }
    } catch (e) {
      rethrow;
    }
  }
}
