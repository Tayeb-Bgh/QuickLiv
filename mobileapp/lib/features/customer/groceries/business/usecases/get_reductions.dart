import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/product_with_reduc_entity.dart';
import 'package:mobileapp/features/customer/groceries/data/repositories/groceries_repository_impl.dart';

class GetReductions {
  final GroceriesRepositoryImpl groceriesRepositoryImpl;

  GetReductions({required this.groceriesRepositoryImpl});

  Future<List<ProductWithReduc>> call(List<Grocery> groceries) async {
    return await groceriesRepositoryImpl.getReductions(groceries);
  }
}
