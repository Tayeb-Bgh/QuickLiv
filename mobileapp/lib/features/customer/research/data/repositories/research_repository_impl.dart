import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapp/core/params/origin_dest_params.dart';
import 'package:mobileapp/core/utils/location_provider.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';
import 'package:mobileapp/features/customer/research/business/entities/product_entity.dart';
import 'package:mobileapp/features/customer/research/data/services/research_service.dart';
import 'package:mobileapp/features/customer/research/business/entities/business_entity.dart';
import 'package:mobileapp/features/customer/research/business/repositories/research_repository_abstr.dart';
import 'package:mobileapp/features/customer/research/data/models/business_model.dart';
import 'package:mobileapp/features/customer/research/data/models/product_business_model.dart';
import 'package:mobileapp/features/customer/research/data/models/product_model.dart';

class ResearchRepositoryImpl {
  final ResearchService researchService;
  final Ref ref;

  ResearchRepositoryImpl({required this.researchService, required this.ref});
  Future<List<Business>> getBusinessesByKeyWord(
    String keyWord,
    double lat,
    double lng,
  ) async {
    final productBusinessModelMap = <int, List<ProductBusinessModel>>{};
    final productModelMap = <int, List<ProductModel>>{};

    List<BusinessModel> businessesModels = [];

    try {
      businessesModels = await researchService.fetchBusinessesByKeyWord(
        keyWord,
      );
    } catch (e, st) {
      return []; // Return early if no businesses could be fetched
    }

    await Future.forEach(businessesModels, (BusinessModel business) async {
      try {
        final productsBusinessModelList = await researchService
            .fetchBusinessProducts(business.idBusns, keyWord);

        productBusinessModelMap[business.idBusns] = productsBusinessModelList;

        final productsModels = await Future.wait(
          productsBusinessModelList.map((prodBusns) async {
            try {
              final prod = await researchService.fetchProductById(
                prodBusns.idProd,
              );
              return prod[0]; // Assuming only one product is returned
            } catch (e, st) {
              return null; // Skip this product
            }
          }),
        );

        // Filter out any nulls
        final nonNullProducts =
            productsModels.whereType<ProductModel>().toList();

        productModelMap[business.idBusns] = nonNullProducts;
      } catch (e, st) {}
    });

    final productEntityMap = <int, List<Product>>{};

    for (final key in productModelMap.keys) {
      final productBusinessModelList = productBusinessModelMap[key]!;
      final productModelList = productModelMap[key]!;

      final products = <Product>[];
      for (final prod in productModelList) {
        try {
          final prodBusns = productBusinessModelList.firstWhere(
            (p) => p.idProd == prod.idProd,
          );

          products.add(
            prod.toEntity(
              key,
              prodBusns.priceProdBusns,
              prodBusns.reducRateProdBusns,
              prodBusns.qttyProdBusns,
            ),
          );
        } catch (e, st) {}
      }

      productEntityMap[key] = products;
    }

    final businessList =
        businessesModels.map((business) async {
          try {
            final durationInSeconds = await ref.watch(
              drivingDurationProvider(
                OriginDestParams(
                  origin: LatLng(lat, lng),
                  destination: LatLng(business.latBusns, business.lngBusns),
                ),
              ).future,
            );

            final distanceInMeters = await ref.watch(
              distanceInMetersProvider(
                OriginDestParams(
                  origin: LatLng(lat, lng),
                  destination: LatLng(business.latBusns, business.lngBusns),
                ),
              ).future,
            );

            final double distanceInKilometers = toKilometers(distanceInMeters);
            final products = productEntityMap[business.idBusns] ?? [];

            return business.toEntity(
              calculateDelivPrice(distanceInKilometers),
              durationInSeconds,
              4.5,
              products,
              distanceInKilometers,
            );
          } catch (e, st) {
            return null;
          }
        }).toList();

    // Remove any null results caused by errors
    final resolvedBusinesses = await Future.wait(businessList);
    return resolvedBusinesses.whereType<Business>().toList();
  }
}
