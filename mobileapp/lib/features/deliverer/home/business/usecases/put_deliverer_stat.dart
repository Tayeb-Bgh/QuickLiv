import '../repositories/deliverer_set_stat_repo.dart';

class PutDelivererStat {
  final DelivererSetStatRepo delivererSetStatRepo;

  
  PutDelivererStat(this.delivererSetStatRepo);
 
  Future<void> execute( bool status) async {
    try {
      await delivererSetStatRepo.changeDelivererStatus( status);
    } catch (e) {
        rethrow;
    }
  }
}
