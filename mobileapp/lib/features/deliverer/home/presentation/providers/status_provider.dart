import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/deliverer/home/business/repositories/deliverer_set_stat_repo.dart';
import 'package:mobileapp/features/deliverer/home/data/repositories/deliverer_set_stat_repo_impl.dart';
import 'package:mobileapp/features/deliverer/home/data/service/deliverer_home_service.dart';
import '../../business/usecases/put_deliverer_stat.dart';

final dioProvider = Provider((ref) => Dio());
final delivererHomeService = Provider(
  (ref) => DelivererHomeService(ref.watch(dioProvider), ref),
);

final delivererSetStatRepoProvider = Provider<DelivererSetStatRepo>((ref) {
  return DelivererSetStatRepoImpl(ref.watch(delivererHomeService));
});

class StatusNotifier extends StateNotifier<bool> {
  final PutDelivererStat putDelivererStat;

  StatusNotifier(this.putDelivererStat) : super(false);
  Future<void> updateStatus(bool newStatus) async {
    if (state != newStatus) {
      try {
        print("ur old status is  :$state | ||| the new state is : $newStatus");
        await putDelivererStat.execute(newStatus);
        state = newStatus;
        print("Status updated to: $newStatus");
      } catch (e) {
        rethrow;
      }
    } else {
      print("Status is already $newStatus, no update needed.");
    }
  }
}

final statusNotifierProvider = StateNotifierProvider<StatusNotifier, bool>((
  ref,
) {
  final delivererSetStatRepo = ref.watch(delivererSetStatRepoProvider);
  final putDelivererStat = PutDelivererStat(delivererSetStatRepo);
  return StatusNotifier(putDelivererStat);
});
