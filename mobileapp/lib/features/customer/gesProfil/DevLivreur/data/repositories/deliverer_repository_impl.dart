import 'package:mobileapp/features/customer/gesProfil/DevLivreur/business/entities/deliverer.dart';
import 'package:mobileapp/features/customer/gesProfil/DevLivreur/business/repositories/deliverer_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:mobileapp/features/customer/gesProfil/DevLivreur/data/service/deliverer_service.dart';

class DelivererRepositoryImpl implements DelivererRepository {
  final Dio dio;
  final WidgetRef ref;
  late final DelivererService delivererService;

  DelivererRepositoryImpl(this.dio, this.ref) {
    delivererService = DelivererService(dio, ref);
  }

  @override
  Future<void> saveDeliverer(Deliverer deliverer) async {
    await delivererService.saveDeliverer(deliverer);
  }

  @override
  Future<void> updateSubmitedClient() async {
    await delivererService.updateSubmitedClient();
  }
}

