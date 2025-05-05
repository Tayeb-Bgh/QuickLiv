import '../repositories/favourites_repository.dart';

class AddFavourites {
  final FavouritesRepository repository;
  AddFavourites({required this.repository});
  Future<void> call( int businessId) async { 
    return await repository.addFavourite(businessId);
  }
}
