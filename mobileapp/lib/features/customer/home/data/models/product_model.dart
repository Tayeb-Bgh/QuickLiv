import 'package:mobileapp/features/customer/home/business/entities/product_reduc.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';

class ProductModel {
  final int idProd;
  final String imgUrlProd;

  ProductModel({required this.idProd, required this.imgUrlProd});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(idProd: json['idProd'], imgUrlProd: json['imgUrlProd']);
  }

  ProductReduc toEntity(
    Grocery? grocery,
    Restaurant? restaurant,
    double reductionRate,
  ) {
    return ProductReduc(
      idProd: idProd,
      imgUrlProd: imgUrlProd,
      reducRateProd: reductionRate,
      grocery: grocery,
      restaurant: restaurant,
    );
  }
}
