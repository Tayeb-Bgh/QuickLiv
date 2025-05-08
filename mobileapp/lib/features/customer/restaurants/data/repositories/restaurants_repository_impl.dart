import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapp/core/params/origin_dest_params.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';
import 'package:mobileapp/core/utils/location_provider.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/product_entity.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';
import 'package:mobileapp/features/customer/restaurants/business/repositories/restaurants_repository.dart';
import 'package:mobileapp/features/customer/restaurants/data/models/business_model.dart';
import 'package:mobileapp/features/customer/restaurants/data/models/product_business_model.dart';
import 'package:mobileapp/features/customer/restaurants/data/models/product_model.dart';
import 'package:mobileapp/features/customer/restaurants/data/services/restaurants_service.dart';

class RestaurantsRepositoryImpl implements RestaurantsRepository {
  final RestaurantsService restaurantsService;
  final Ref ref;

  RestaurantsRepositoryImpl({
    required this.restaurantsService,
    required this.ref,
  });

  @override
  Future<List<Restaurant>> getRestaurants(
    String wilaya,
    double lat,
    double lng,
  ) async {
    List<BusinessModel> restaurantsModelList = await restaurantsService
        .fetchRestaurantsModelsByLocation("Béjaïa", lat, lng, null);

    final restaurants = await Future.wait(
      restaurantsModelList.map((restaurant) async {
        final durationInSeconds = await ref.watch(
          drivingDurationProvider(
            OriginDestParams(
              origin: LatLng(lat, lng),
              destination: LatLng(restaurant.latBusns, restaurant.lngBusns),
            ),
          ).future,
        );

        final distanceInMeters = await ref.watch(
          distanceInMetersProvider(
            OriginDestParams(
              origin: LatLng(lat, lng),
              destination: LatLng(restaurant.latBusns, restaurant.lngBusns),
            ),
          ).future,
        );

        final double distanceInKilometers = toKilometers(distanceInMeters);
        return restaurant.toEntity(
          false,
          distanceInKilometers,
          durationInSeconds,
          4.5,
          distanceInKilometers,
        );
      }),
    );

    return restaurants;
    // ! UNCOMMENT AFTER
    /* 

    print("[DEBUG] filtering by distance ");

    final List<restaurant> restaurantsAtLimitedDistance =
        restaurants.where((groc) => groc.distance <= 15).toList();
    print("[DEBUG] filtering finished !");

    return restaurantsAtLimitedDistance; */
  }

  @override
  Future<List<Restaurant>> getRestaurantsByCategory(
    String wilaya,
    double lat,
    double lng,
    String? category,
  ) async {
    List<BusinessModel> restaurantsModelList = await restaurantsService
        .fetchRestaurantsModelsByLocation("Béjaïa", lat, lng, category);

    final restauarnts = await Future.wait(
      restaurantsModelList.map((restaurant) async {
        final durationInSeconds = await ref.watch(
          drivingDurationProvider(
            OriginDestParams(
              origin: LatLng(lat, lng),
              destination: LatLng(restaurant.latBusns, restaurant.lngBusns),
            ),
          ).future,
        );

        final distanceInMeters = await ref.watch(
          distanceInMetersProvider(
            OriginDestParams(
              origin: LatLng(lat, lng),
              destination: LatLng(restaurant.latBusns, restaurant.lngBusns),
            ),
          ).future,
        );

        final double distanceInKilometers = toKilometers(distanceInMeters);
        return restaurant.toEntity(
          false,
          distanceInKilometers,
          durationInSeconds,
          4.5,
          distanceInKilometers,
        );
      }),
    );

    return restauarnts;
    // ! UNCOMMENT AFTER
    /* 

    print("[DEBUG] filtering by distance ");

    final List<restaurant> restaurantsAtLimitedDistance =
        restaurants.where((groc) => groc.distance <= 15).toList();
    print("[DEBUG] filtering finished !");

    return restaurantsAtLimitedDistance; */
  }

  @override
  Future<List<Product>> getBestProducts(List<Restaurant> restaurants) async {
    final Map<int, List> productBusinessMap = {};
    for (Restaurant restaurant in restaurants) {
      try {
        final List<ProductBusinessModel> products = await restaurantsService
            .fetchProductsOfRestaurant(restaurant.id);

        productBusinessMap[restaurant.id] = products;
      } catch (e) {
        e.toString();
      }
    }

    final Map<int, List<ProductModel>> productMap = {};

    for (final entry in productBusinessMap.entries) {
      final restaurantId = entry.key;
      final productBusinessList = entry.value;

      final List<ProductModel> productModelsList = [];

      for (final productBusiness in productBusinessList) {
        final productId = productBusiness.idProd;
        final product = await restaurantsService.fetchProductById(productId);
        productModelsList.add(product);
      }

      productMap[restaurantId] = productModelsList;
    }

    final List<Product> productsList = [];

    for (final entry in productMap.entries) {
      final restaurantId = entry.key;
      final products = entry.value;

      for (final product in products) {
        final idProd = product.idProd;
        final idBusns = restaurantId;
        final nameProd = product.nameProd;
        final imgUrl = product.imgUrlProd;
        final description = product.descProd;
        final unit = product.unitProd;
        final nameBusns =
            restaurants
                .where((restaurant) => restaurant.id == restaurantId)
                .first
                .name;
        final delivDuration =
            restaurants
                .where((restaurant) => restaurant.id == restaurantId)
                .first
                .delivTime;

        final prodBusns = productBusinessMap[restaurantId];

        final price =
            prodBusns!
                .where((prodBusns) => prodBusns.idProd == idProd)
                .first
                .priceProdBusns;

        productsList.add(
          Product(
            idProd: idProd,
            unit: unit,
            idBusns: idBusns,
            nameProd: nameProd,
            nameBusns: nameBusns,
            imgUrl: imgUrl,
            delivDuration: delivDuration,
            price: price,
            description: description,
          ),
        );
      }
    }

    return productsList;
  }
}
