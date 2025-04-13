import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/groceries/data/repositories/groceries_repository_impl.dart';

class Get {
  final GroceriesRepositoryImpl groceriesRepositoryImpl;

  Get({required this.groceriesRepositoryImpl});

  Future<List<Grocery>> call() {
    return groceriesRepositoryImpl.getGroceries();
  }
}
