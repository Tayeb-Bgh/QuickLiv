import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/home/business/entities/product_reduc.dart';
import 'package:mobileapp/features/customer/home/data/repositories/home_repository_impl.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';

class GetPromotions {
  final HomeRepositoryImpl homeRepositoryImpl;
  GetPromotions({required this.homeRepositoryImpl});

  Future<List<ProductReduc>> call(
    List<Grocery> groceries,
    List<Restaurant> restaurants,
  ) {
    return homeRepositoryImpl.getBestReductions(groceries, restaurants);
  }
}
