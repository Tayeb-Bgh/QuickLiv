import '../entities/business_entity.dart';
import '../repositories/favourites_repository.dart';

class GetFavorites {
  final FavouritesRepository repository;
  GetFavorites({required this.repository});
  Future<List<Business>> call(String wilaya, double lat, double lng) async { 
    return await repository.getFavourites(wilaya,lat,lng);
  }
}
