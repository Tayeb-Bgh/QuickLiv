import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapp/core/utils/location_provider.dart';
import 'package:mobileapp/features/customer/favourites/business/entities/business_entity.dart';
import 'package:mobileapp/features/customer/favourites/business/repositories/favourites_repository.dart';
import 'package:mobileapp/features/customer/favourites/business/usecases/add_favourites.dart';
import 'package:mobileapp/features/customer/favourites/business/usecases/get_favourites.dart';
import 'package:mobileapp/features/customer/favourites/business/usecases/get_favourites_by_type.dart';
import 'package:mobileapp/features/customer/favourites/business/usecases/remove_favourite.dart';
import 'package:mobileapp/features/customer/favourites/data/repositories/favourites_repository_impl.dart';
import 'package:mobileapp/features/customer/favourites/data/service/favourites_service.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final favouritesServiceProvider = Provider<FavouritesService>((ref) {
  return FavouritesService(ref.watch(dioProvider), ref);
});

final favouritesRepositoryProvider = Provider<FavouritesRepository>((ref) {
  return FavouritesRepositoryImpl(
    ref: ref,
    favouritesService: ref.watch(favouritesServiceProvider),
  );
});

final getFavouritesProvider = Provider<GetFavorites>((ref) {
  return GetFavorites(repository: ref.watch(favouritesRepositoryProvider));
});

final getFavouritesByTypeProvider = Provider<GetFavouritesByType>((ref) {
  return GetFavouritesByType(
    repository: ref.watch(favouritesRepositoryProvider),
  );
});

final addFavouritesProvider = Provider<AddFavourites>((ref) {
  return AddFavourites(repository: ref.watch(favouritesRepositoryProvider));
});

final removeFavouritesProvider = Provider<RemoveFavourite>((ref) {
  return RemoveFavourite(repository: ref.watch(favouritesRepositoryProvider));
});

final selectedTypeProvider = StateProvider<String?>((ref) => null);

final prov = FutureProvider.family<List<Business>, String?>((ref, type) async {
  final LatLng? currentPos = await ref.watch(locationProvider.future);
  print(type);
  if (currentPos == null) return [];

  final String currentWilaya = await ref.watch(
    wilayaProvider(LatLng(currentPos.latitude, currentPos.longitude)).future,
  );

  if (type == null) {
    return await ref
        .watch(getFavouritesProvider)
        .call(currentWilaya, currentPos.latitude, currentPos.longitude);
  } else {
    return await ref
        .watch(getFavouritesByTypeProvider)
        .call(type, currentWilaya, currentPos.latitude, currentPos.longitude);
  }
});



final favouritesListProvider = FutureProvider<List<Business>>((ref) async {
  return await ref.watch(prov(null).future);
});

final favouritesByTypeListProvider = FutureProvider<List<Business>>((ref) async {
  final type = ref.watch(selectedTypeProvider);
  return await ref.watch(prov(type).future);
});

class FavouriteNotifier extends StateNotifier<Set<int>> {
  final AddFavourites _addFavourites;
  final RemoveFavourite _removeFavourites;

  FavouriteNotifier({
    required AddFavourites addFavourites,
    required RemoveFavourite removeFavourites,
  }) : _addFavourites = addFavourites,
       _removeFavourites = removeFavourites,
       super({});

  // Ajouter un favori
  Future<void> addFavourite(int businessId) async {
    state = {...state, businessId};
    await _addFavourites.call(businessId);
  }

  // Retirer un favori
  Future<void> removeFavourite(int businessId) async {
    state = {...state}..remove(businessId);
    await _removeFavourites.call(businessId);
  }

  // Vérifier si un business est favori
  bool isLiked(int businessId) {
    return state.contains(businessId);
  }
}

final userFavouritesProvider = FutureProvider<List<int>>((ref) async {
  final service = ref.watch(favouritesServiceProvider);
  final favourites =
      await service.fetchCustomerFavourites(); // liste de Business
  return favourites.map((b) => b.idBusns).toList(); // Liste des IDs favoris
});

final favouriteProvider = StateNotifierProvider<FavouriteNotifier, Set<int>>(
  (ref) => FavouriteNotifier(
    addFavourites: ref.watch(addFavouritesProvider),
    removeFavourites: ref.watch(removeFavouritesProvider),
  ),
);
