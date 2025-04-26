import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/deliverer/home/business/repositories/deliverer_set_stat_repo.dart';
import 'package:mobileapp/features/deliverer/home/data/repositories/deliverer_set_stat_repo_impl.dart';
import 'package:mobileapp/features/deliverer/home/data/service/deliverer_home_service.dart';
import 'package:mobileapp/features/deliverer/home/presentation/providers/deliverer_home_provider.dart';
import 'package:mobileapp/features/deliverer/home/business/usecases/put_deliverer_stat.dart';
import 'package:dio/dio.dart';

final dioProvider = Provider((ref) => Dio());

final delivererHomeService = Provider(
  (ref) => DelivererHomeService(ref.watch(dioProvider), ref),
);

final delivererSetStatRepoProvider = Provider<DelivererSetStatRepo>((ref) {
  return DelivererSetStatRepoImpl(ref.watch(delivererHomeService));
});

class StatusNotifier extends AsyncNotifier<bool> {
  late final PutDelivererStat _putDelivererStat;

  @override
  Future<bool> build() async {
    final repo = ref.watch(delivererSetStatRepoProvider);
    _putDelivererStat = PutDelivererStat(repo);

    try {
      final stat = await ref.read(delivererStatFutureProvider.future);
      final isOnline = stat.isOnline;

      state = AsyncValue.data(isOnline);
      print('the state is here is aits init $isOnline');
      return isOnline;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<void> updateStatus(bool newStatus) async {
    final current = state.value;
    if (current == newStatus) return;

    state = const AsyncValue.loading();
    try {
      await _putDelivererStat.execute(newStatus);
      state = AsyncValue.data(newStatus);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

/// Use this in widgets
final statusNotifierProvider = AsyncNotifierProvider<StatusNotifier, bool>(
  StatusNotifier.new,
);
