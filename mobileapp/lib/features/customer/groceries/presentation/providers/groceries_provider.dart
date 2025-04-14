import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/groceries/business/usecases/get_by_wilaya_or_city.dart';
import 'package:mobileapp/features/customer/groceries/data/repositories/groceries_repository_impl.dart';
import 'package:mobileapp/features/customer/groceries/data/services/groceries_service.dart';
import 'package:mobileapp/features/maps_example/location_provider.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final groceriesServiceProvider = Provider<GroceriesService>((ref) {
  return GroceriesService(ref.watch(dioProvider));
});

final groceriesRepositoryProvider = Provider<GroceriesRepositoryImpl>((ref) {
  return GroceriesRepositoryImpl(
    groceriesService: ref.watch(groceriesServiceProvider),
    ref: ref,
  );
});

final getGroceriesProvider = Provider<GetByWilayaOrCity>((ref) {
  return GetByWilayaOrCity(
    groceriesRepositoryImpl: ref.watch(groceriesRepositoryProvider),
  );
});

final groceriesListProvider = FutureProvider<List<Grocery>>((ref) async {
  final LatLng? currentPos = await ref.watch(locationProvider.future);

  if (currentPos == null) return [];

  final String currentWilaya = await ref.watch(
    wilayaProvider(LatLng(currentPos.latitude, currentPos.longitude)).future,
  );

  return await ref
      .watch(getGroceriesProvider)
      .call(currentWilaya, currentPos.latitude, currentPos.longitude);
});
