import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapp/core/params/origin_dest_params.dart';
import 'package:mobileapp/core/utils/location_provider.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';
import 'package:mobileapp/features/customer/favourites/business/entities/business_entity.dart';
import 'package:mobileapp/features/customer/favourites/business/repositories/favourites_repository.dart';
import 'package:mobileapp/features/customer/favourites/data/models/business_model.dart';
import 'package:mobileapp/features/customer/favourites/data/service/favourites_service.dart';

class FavouritesRepositoryImpl implements FavouritesRepository {
  final FavouritesService favouritesService;
  final Ref ref;

  FavouritesRepositoryImpl({
    required this.favouritesService,  
    required this.ref,
  });
  
  @override
Future<List<Business>> getFavourites(String wilaya, double lat, double lng) async {
  try {
    final List<BusinessModel> businessModelsList = await favouritesService
        .fetchCustomerFavourites();

    final favourites = await Future.wait(
      businessModelsList.map((model) => _enrichBusinessModel(model, lat, lng)),
    );

    return favourites;
  } catch (e) {
    print('Error getting favourites: $e');
    rethrow;
  }
}

@override
Future<List<Business>> getFavouritesByType(String? businessType, String wilaya, double lat, double lng) async {
  try {
    if (businessType == null) {
      return [];
    }
    
    final List<BusinessModel> businessModels = 
        await favouritesService.filterFavouritesByType(businessType);
    
    final favourites = await Future.wait(
      businessModels.map((model) => _enrichBusinessModel(model, lat, lng)),
    );

    return favourites;
  } catch (e) {
    print('Error getting favourites by type: $e');
    rethrow;
  }
}

Future<Business> _enrichBusinessModel(BusinessModel model, double lat, double lng) async {
  try {
    final durationInSeconds = await ref.read(
      drivingDurationProvider(
        OriginDestParams(
          origin: LatLng(lat, lng),
          destination: LatLng(model.latBusns, model.lngBusns),
        ),
      ).future,
    );

    final distanceInMeters = await ref.read(
      distanceInMetersProvider(
        OriginDestParams(
          origin: LatLng(lat, lng),
          destination: LatLng(model.latBusns, model.lngBusns),
        ),
      ).future,
    );

    final double distanceInKilometers = toKilometers(distanceInMeters);
    return model.toEntity(
      true, 
      distanceInKilometers,
      durationInSeconds,
      4.5, 
      true, 
    );
  } catch (e) {
    print('Error enriching business model: $e');
    return model.toEntity(true, 0, 0, 3.0, true);
  }
}


  @override
  Future<bool> addFavourite(int businessId) async {
    try {
      return await favouritesService.addFavourite(businessId);
    } catch (e) {
     print('Error adding favourite: $e');
      return false;
    }
  }

  @override
  Future<bool> removeFavourite( int businessId) async {
    try {
      return await favouritesService.deleteFavourite(businessId);
    } catch (e) {
      print('Error removing favourite: $e');
       return false;
    }
  }
  
}
