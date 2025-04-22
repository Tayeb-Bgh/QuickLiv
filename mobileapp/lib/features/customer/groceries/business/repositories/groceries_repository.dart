import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/product_with_reduc_entity.dart';

abstract class GroceriesRepository {
  Future<List<Grocery>> getGroceries(String wilaya, double lat, double lng);
  Future<List<Grocery>> getGroceriesByCategory(
    String wilaya,
    double lat,
    double lng,
    String category,
  );
  Future<List<ProductWithReduc>> getReductions(List<Grocery> groceries);
}
