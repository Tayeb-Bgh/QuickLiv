import 'package:mobileapp/features/customer/grocery_opened/business/entities/product_entity.dart';
import 'package:mobileapp/features/customer/grocery_opened/data/repositories/grocery_opened_repository_impl.dart';

class GetProducts {
  GroceryOpenedRepositoryImpl groceryOpenedRepositoryImpl;

  GetProducts({required this.groceryOpenedRepositoryImpl});

  Future<List<Product>> call(int idGroc) {
    return groceryOpenedRepositoryImpl.getProducts(idGroc);
  }
}
