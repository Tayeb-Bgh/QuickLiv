import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';

class ProductReduc {
  final int idProd;
  final Grocery? grocery;
  final Restaurant? restaurant;
  final String imgUrlProd;
  final double reducRateProd;

  ProductReduc({
    required this.idProd,
    this.restaurant,
    this.grocery,
    required this.imgUrlProd,
    required this.reducRateProd,
  });
}
