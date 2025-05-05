import 'package:mobileapp/features/customer/favourites/business/repositories/favourites_repository.dart';

class RemoveFavourite {
  final FavouritesRepository repository;
  RemoveFavourite({required this.repository});
  Future<void> call(int businessId) async {
    return await repository.removeFavourite(
      businessId
    );
  }
}
