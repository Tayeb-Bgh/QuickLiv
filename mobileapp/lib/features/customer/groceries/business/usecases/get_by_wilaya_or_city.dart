import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/groceries/data/repositories/groceries_repository_impl.dart';

class GetByWilayaOrCity {
  final GroceriesRepositoryImpl groceriesRepositoryImpl;

  GetByWilayaOrCity({required this.groceriesRepositoryImpl});

  Future<List<Grocery>> call(String wilaya, double lat, double lng) {
    return groceriesRepositoryImpl.getGroceries(wilaya, lat, lng);
  }
}
