import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/product_entity.dart';
import 'package:mobileapp/features/customer/restaurants/business/usecases/get_near_restaurants.dart';
import 'package:mobileapp/features/customer/restaurants/business/usecases/get_near_restaurants_by_category.dart';
import 'package:mobileapp/features/customer/restaurants/business/usecases/get_best_products.dart';
import 'package:mobileapp/features/customer/restaurants/data/repositories/restaurants_repository_impl.dart';
import 'package:mobileapp/features/customer/restaurants/data/services/restaurants_service.dart';
import 'package:mobileapp/core/utils/location_provider.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final restaurantsServiceProvider = Provider<RestaurantsService>((ref) {
  return RestaurantsService(ref.watch(dioProvider));
});

final restaurantsRepositoryProvider = Provider<RestaurantsRepositoryImpl>((
  ref,
) {
  return RestaurantsRepositoryImpl(
    restaurantsService: ref.watch(restaurantsServiceProvider),
    ref: ref,
  );
});

final getRestaurantsProvider = Provider<GetNearRestaurants>((ref) {
  return GetNearRestaurants(
    restaurantsRepositoryImpl: ref.watch(restaurantsRepositoryProvider),
  );
});

final restaurantsListProvider = FutureProvider<List<Restaurant>>((ref) async {
  final LatLng? currentPos = await ref.watch(locationProvider.future);

  if (currentPos == null) return [];

  final String currentWilaya = await ref.watch(
    wilayaProvider(LatLng(currentPos.latitude, currentPos.longitude)).future,
  );

  return await ref
      .watch(getRestaurantsProvider)
      .call(currentWilaya, currentPos.latitude, currentPos.longitude);
});

final selectedCategoryProvider = StateProvider<String?>((ref) => null);

final getrestaurantsByCategoryProvider = Provider<GetNearRestaurantsByCategory>(
  (ref) {
    return GetNearRestaurantsByCategory(
      restaurantsRepositoryImpl: ref.watch(restaurantsRepositoryProvider),
    );
  },
);

final restaurantsByCategoryListProvider = FutureProvider<List<Restaurant>>((
  ref,
) async {
  final LatLng? currentPos = await ref.watch(locationProvider.future);

  if (currentPos == null) return [];

  final String currentWilaya = await ref.watch(
    wilayaProvider(LatLng(currentPos.latitude, currentPos.longitude)).future,
  );

  final String? category = ref.watch(selectedCategoryProvider);
  return await ref
      .watch(getrestaurantsByCategoryProvider)
      .call(currentWilaya, currentPos.latitude, currentPos.longitude, category);
});

final prov = FutureProvider.family<List<Restaurant>, String?>((
  ref,
  params,
) async {
  final String? category = params;
  final LatLng? currentPos = await ref.watch(locationProvider.future);
  if (currentPos == null) return [];

  final String currentWilaya = await ref.watch(
    wilayaProvider(LatLng(currentPos.latitude, currentPos.longitude)).future,
  );

  return await ref
      .watch(getrestaurantsByCategoryProvider)
      .call(currentWilaya, currentPos.latitude, currentPos.longitude, category);
});

final getBestProductsProvider = Provider<GetBestProducts>((ref) {
  return GetBestProducts(
    repositoryImpl: ref.watch((restaurantsRepositoryProvider)),
  );
});

final bestProductsListProvider = FutureProvider<List<Product>>((ref) async {
  final restaurants = await ref.watch(restaurantsListProvider.future);

  for (final restaurant in restaurants)
    print("${restaurant.id}   ${restaurant.name}    ${restaurant.category}");
  return await ref.watch(getBestProductsProvider).call(restaurants);
});
