// provider livraison dispo setSate true/false

// provider position actuelle sélectionné

// provider iste des des trucs
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapp/core/utils/location_provider.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/product_with_reduc_entity.dart';
import 'package:mobileapp/features/customer/groceries/business/usecases/get_reductions.dart';
import 'package:mobileapp/features/customer/groceries/presentation/providers/groceries_provider.dart';
import 'package:mobileapp/features/customer/home/business/entities/product_reduc.dart';
import 'package:mobileapp/features/customer/home/business/usecases/get_promotions.dart';
import 'package:mobileapp/features/customer/home/data/repositories/home_repository_impl.dart';
import 'package:mobileapp/features/customer/home/data/service/home_service.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';
import 'package:mobileapp/features/customer/restaurants/presentation/providers/restaurants_provider.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final homeServiceProvider = Provider<HomeService>((ref) {
  return HomeService(dio: ref.watch(dioProvider));
});

final homeRepositoryProvider = Provider<HomeRepositoryImpl>((ref) {
  return HomeRepositoryImpl(homeService: ref.watch(homeServiceProvider));
});

final getPromostionsProvider = Provider<GetPromotions>((ref) {
  return GetPromotions(homeRepositoryImpl: ref.watch(homeRepositoryProvider));
});

final groceriesListProvidier = FutureProvider<List<Grocery>>((ref) async {
  final LatLng? currentPos = await ref.watch(locationProvider.future);

  if (currentPos == null) return [];

  final String currentWilaya = await ref.watch(
    wilayaProvider(LatLng(currentPos.latitude, currentPos.longitude)).future,
  );

  return await ref
      .watch(getGroceriesProvider)
      .call("Béjaïa", currentPos.latitude, currentPos.longitude);
});

final restaurantsListProvidier = FutureProvider<List<Restaurant>>((ref) async {
  final LatLng? currentPos = await ref.watch(locationProvider.future);

  if (currentPos == null) return [];

  final String currentWilaya = await ref.watch(
    wilayaProvider(LatLng(currentPos.latitude, currentPos.longitude)).future,
  );

  return await ref
      .watch(getRestaurantsProvider)
      .call("Béjaïa", currentPos.latitude, currentPos.longitude);
});

final bestReductionsListProvider = FutureProvider<List<ProductReduc>>((
  ref,
) async {
  final groceries = await ref.watch(groceriesListProvider.future);
  final restaurants = await ref.watch(restaurantsListProvider.future);

  return ref.watch(getPromostionsProvider).call(groceries, restaurants);
});
