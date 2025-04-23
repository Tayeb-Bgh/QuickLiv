import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/deliverer/home/business/entities/deliverer_status_entity.dart';
import 'package:mobileapp/features/deliverer/home/business/usecases/get_deliverer_stat.dart';
import 'package:mobileapp/features/deliverer/home/data/repositories/deliverer_home_repo_impl.dart';
import 'package:mobileapp/features/deliverer/home/data/service/deliverer_home_service.dart';

final dioProvider = Provider((ref) => Dio());

final delivererHomeService = Provider(
  (ref) => DelivererHomeService(ref.watch(dioProvider), ref),
);

final delivererHomeRepo = Provider(
  (ref) => DelivererHomeRepoImpl(ref.watch(delivererHomeService)),
);
final getDelivererStat = Provider(
  (ref) => GetDelivererStat(ref.watch(delivererHomeRepo)),
);

final delivererStatFutureProvider = FutureProvider<DelivererStatusEntity>((
  ref,
) async {
  return await ref.watch(getDelivererStat).call();
});

