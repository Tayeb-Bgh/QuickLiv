import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapp/core/params/origin_dest_params.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/groceries/business/repositories/groceries_repository.dart';
import 'package:mobileapp/features/customer/groceries/data/models/business_model.dart';
import 'package:mobileapp/features/customer/groceries/data/services/groceries_service.dart';
import 'package:mobileapp/features/maps_example/location_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';

class GroceriesRepositoryImpl implements GroceriesRepository {
  final GroceriesService groceriesService;
  final Ref ref;

  GroceriesRepositoryImpl({required this.groceriesService, required this.ref});

  @override
  Future<List<Grocery>> getGroceries(
    String wilaya,
    double lat,
    double lng,
  ) async {
    print("[DEBUG] $wilaya");
    print("[DEBUG] $lng");
    print("[DEBUG] $lat");

    print("[DEBUG] FETCHING DATA FROM DB ...");

    List<BusinessModel> groceriesModelList = await groceriesService
        .fetchGroceriesModels("Béjaïa", lat, lng);

    if (groceriesModelList.isEmpty) {
      return [];
    }
    print("[DEBUG] DATA FETCHED");

    final groceries = await Future.wait(
      groceriesModelList.map((grocery) async {
        final durationInSeconds = await ref.watch(
          drivingDurationProvider(
            OriginDestParams(
              origin: LatLng(lat, lng),
              destination: LatLng(grocery.latBusns, grocery.lngBusns),
            ),
          ).future,
        );

        final distanceInMeters = await ref.watch(
          distanceInMetersProvider(
            OriginDestParams(
              origin: LatLng(lat, lng),
              destination: LatLng(grocery.latBusns, grocery.lngBusns),
            ),
          ).future,
        );

        final double distanceInKilometers = toKilometers(distanceInMeters);

        return grocery.toEntity(
          false,
          distanceInKilometers,
          durationInSeconds,
          4.5,
        );
      }),
    );

    return groceries;
  }
}
