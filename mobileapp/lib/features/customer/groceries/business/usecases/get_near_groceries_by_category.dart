import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/groceries/data/repositories/groceries_repository_impl.dart';

class GetNearGroceriesByCategory {
  final GroceriesRepositoryImpl groceriesRepositoryImpl;

  GetNearGroceriesByCategory({required this.groceriesRepositoryImpl});

  Future<List<Grocery>> call(
    String wilaya,
    double lat,
    double lng,
    String? category,
  ) {
    return groceriesRepositoryImpl.getGroceriesByCategory(
      wilaya,
      lat,
      lng,
      category,
    );
  }
}
