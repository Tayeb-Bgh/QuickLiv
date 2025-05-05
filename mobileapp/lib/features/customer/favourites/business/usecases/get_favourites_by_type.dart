import '../entities/business_entity.dart';
import '../repositories/favourites_repository.dart';

class GetFavouritesByType {
  final FavouritesRepository repository;
  GetFavouritesByType({required this.repository});
  Future<List<Business>> call(String? businessType,String wilaya, double lat, double lng) async { 
    return await repository.getFavouritesByType(businessType,wilaya,lat,lng);
  }
}
