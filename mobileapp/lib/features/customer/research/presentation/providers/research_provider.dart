import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapp/core/config/location_config.dart';
import 'package:mobileapp/features/customer/research/business/entities/business_entity.dart';
import 'package:mobileapp/features/customer/research/business/usecases/filter_by_type.dart';
import 'package:mobileapp/features/customer/research/business/usecases/get_business_products.dart';
import 'package:mobileapp/features/customer/research/data/repositories/research_repository_impl.dart';
import 'package:mobileapp/features/customer/research/data/services/research_service.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

final researchServiceProcide = Provider<ResearchService>((ref) {
  return ResearchService(dio: ref.watch(dioProvider));
});

final researchRepositoryProvider = Provider<ResearchRepositoryImpl>((ref) {
  return ResearchRepositoryImpl(
    researchService: ref.watch(researchServiceProcide),
    ref: ref,
  );
});

final getBusinessesProvider = Provider<GetBusinessProducts>((ref) {
  return GetBusinessProducts(
    researchRepository: ref.watch(researchRepositoryProvider),
  );
});

final filterBusinessesProvider = Provider<FilterByType>((ref) {
  return FilterByType();
});

final searchedBusinessesProvider = FutureProvider<List<Business>>((ref) async {
  if (ref.watch(searchTextProvider).isEmpty) return [];

  LatLng? location = await ref.watch(locationServiceProvider).getUserPosition();
  if (location == null) return [];
  return await ref
      .watch(getBusinessesProvider)
      .call(
        ref.watch(searchTextProvider),
        location.latitude,
        location.longitude,
      );
});

final selectedTypeProvider = StateProvider<String?>((ref) => null);

final searchTextProvider = StateProvider<String>((ref) => "");

final searchControllerProvider = Provider.autoDispose<TextEditingController>((
  ref,
) {
  final initialText = ref.read(searchTextProvider); // read instead of watch
  final controller = TextEditingController(text: initialText);

  ref.onDispose(() => controller.dispose());

  return controller;
});
