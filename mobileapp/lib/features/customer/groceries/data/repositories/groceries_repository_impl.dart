import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapp/core/params/origin_dest_params.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/product_with_reduc_entity.dart';
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
    print("[DEBUG] fetching business models ...");

    List<BusinessModel> groceriesModelList = await groceriesService
        .fetchGroceriesModelsByLocation("Béjaïa", lat, lng);

    print("[DEBUG] business models fetched !");

    print("[DEBUG] converting business models to entities ...");
    int i = 1;
    final groceries = await Future.wait(
      groceriesModelList.map((grocery) async {
        print("[DEBUG] calculating duration in seconds for item $i ");

        final durationInSeconds = await ref.watch(
          drivingDurationProvider(
            OriginDestParams(
              origin: LatLng(lat, lng),
              destination: LatLng(grocery.latBusns, grocery.lngBusns),
            ),
          ).future,
        );
        print("[DEBUG] duration calculous finished !");

        print("[DEBUG] calculating distance for item $i ");

        final distanceInMeters = await ref.watch(
          distanceInMetersProvider(
            OriginDestParams(
              origin: LatLng(lat, lng),
              destination: LatLng(grocery.latBusns, grocery.lngBusns),
            ),
          ).future,
        );

        print("[DEBUG] distance calculous finished ! ");

        final double distanceInKilometers = toKilometers(distanceInMeters);
        i++;
        return grocery.toEntity(
          false,
          distanceInKilometers,
          durationInSeconds,
          4.5,
          distanceInKilometers,
        );
      }),
    );

    print("[DEBUG] filtering by distance ");

    final List<Grocery> groceriesAtLimitedDistance =
        groceries.where((groc) => groc.distance <= 15).toList();
    print("[DEBUG] filtering finished !");

    return groceriesAtLimitedDistance;
  }
}
