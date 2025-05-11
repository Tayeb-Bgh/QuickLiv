import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapp/core/params/origin_dest_params.dart';
import 'package:mobileapp/core/utils/location_provider.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/product_with_reduc_entity.dart';
import 'package:mobileapp/features/customer/groceries/business/repositories/groceries_repository.dart';
import 'package:mobileapp/features/customer/groceries/data/models/business_model.dart';
import 'package:mobileapp/features/customer/groceries/data/models/product_business_model.dart';
import 'package:mobileapp/features/customer/groceries/data/models/product_model.dart';
import 'package:mobileapp/features/customer/groceries/data/services/groceries_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    List<BusinessModel> groceriesModelList = await groceriesService
        .fetchGroceriesModelsByLocation("Béjaïa", lat, lng, null);

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
          calculateDelivPrice(distanceInKilometers),
          durationInSeconds,
          Random().nextDouble() * 2 + 3,
          distanceInKilometers,
        );
      }),
    );

    return groceries;
    // ! UNCOMMENT AFTER
    /* 

    print("[DEBUG] filtering by distance ");

    final List<Grocery> groceriesAtLimitedDistance =
        groceries.where((groc) => groc.distance <= 15).toList();
    print("[DEBUG] filtering finished !");

    return groceriesAtLimitedDistance; */
  }

  @override
  Future<List<Grocery>> getGroceriesByCategory(
    String wilaya,
    double lat,
    double lng,
    String? category,
  ) async {
    List<BusinessModel> groceriesModelList = await groceriesService
        .fetchGroceriesModelsByLocation("Béjaïa", lat, lng, category);

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
          calculateDelivPrice(distanceInKilometers),
          durationInSeconds,
          Random().nextDouble() * 2 + 3,
          distanceInKilometers,
        );
      }),
    );

    return groceries;
    // ! UNCOMMENT AFTER
    /* 

    print("[DEBUG] filtering by distance ");

    final List<Grocery> groceriesAtLimitedDistance =
        groceries.where((groc) => groc.distance <= 15).toList();
    print("[DEBUG] filtering finished !");

    return groceriesAtLimitedDistance; */
  }

  @override
  Future<List<ProductWithReduc>> getReductions(List<Grocery> groceries) async {
    final Map<int, List> productBusinessMap = {};
    for (Grocery grocery in groceries) {
      try {
        final List<ProductBusinessModel> reductions = await groceriesService
            .fetchReductionsOfGrocey(grocery.id);

        productBusinessMap[grocery.id] = reductions;
      } catch (e) {
        e.toString();
      }
    }

    final Map<int, List<ProductModel>> productMap = {};

    for (final entry in productBusinessMap.entries) {
      final groceryId = entry.key;
      final productBusinessList = entry.value;

      final List<ProductModel> productsList = [];

      for (final productBusiness in productBusinessList) {
        final productId = productBusiness.idProd;
        final product = await groceriesService.fetchProductById(productId);
        productsList.add(product);
      }

      productMap[groceryId] = productsList;
    }

    final List<ProductWithReduc> reductionsList = [];

    for (final entry in productMap.entries) {
      final groceryId = entry.key;
      final productList = entry.value;

      for (final product in productList) {
        final idProd = product.idProd;
        final idBusns = groceryId;
        final nameProd = product.nameProd;
        final imgUrl = product.imgUrlProd;
        final bool unitProd = product.unitProd;
        final nameBusns =
            groceries.where((grocery) => grocery.id == groceryId).first.name;
        final delivDuration =
            groceries
                .where((grocery) => grocery.id == groceryId)
                .first
                .delivTime;

        final prodBusns = productBusinessMap[groceryId];
        final reducRate =
            prodBusns!
                .where((prodBusns) => prodBusns.idProd == idProd)
                .first
                .reducRateProdBusns;

        final price =
            prodBusns
                .where((prodBusns) => prodBusns.idProd == idProd)
                .first
                .priceProdBusns;

        reductionsList.add(
          ProductWithReduc(
            description: product.description,
            idProd: idProd,
            idBusns: idBusns,
            nameProd: nameProd,
            nameBusns: nameBusns,
            imgUrl: imgUrl,
            reducRate: reducRate,
            delivDuration: delivDuration,
            price: price,
            priceWithReduc: getPriceWithReduction(price, reducRate),
            unit: unitProd,
          ),
        );
      }
    }

    return reductionsList;
  }
}
