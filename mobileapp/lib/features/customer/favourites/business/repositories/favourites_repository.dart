import '../entities/business_entity.dart';

abstract class FavouritesRepository {
  Future<List<Business>> getFavourites(String wilaya, double lat, double lng);
  Future<void> removeFavourite( int businessId);
  Future<void> addFavourite( int businessId);
  Future<List<Business>> getFavouritesByType( String? businessType, String wilaya, double lat, double lng);
}