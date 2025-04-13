import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';

abstract class GroceriesRepository {
  Future<List<Grocery>> getGroceries();
}
