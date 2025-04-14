import 'package:mobileapp/features/customer/groceries/business/entities/product_with_reduc_entity.dart';
import 'package:mobileapp/core/utils/utility_functions.dart';

class ProductModel {
  final int idProd;
  final String nameProd;
  final String imgUrlProd;
  final bool unitProd;

  ProductModel({
    required this.idProd,
    required this.nameProd,
    required this.imgUrlProd,
    required this.unitProd,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      idProd: json["idProd"],
      nameProd: json["nameProd"],
      imgUrlProd: json["imgUrlProd"],
      unitProd: json["unitProd"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idProd": idProd,
      "nameProd": nameProd,
      "imgUrlProd": imgUrlProd,
      "unitProd": unitProd,
    };
  }

  ProductWithReduc toEntity(
    int delivDuration,
    int idBusns,
    String nameBusns,
    double price,
    double reducRate,
  ) {
    return ProductWithReduc(
      idProd: idProd,
      idBusns: idBusns,
      nameProd: nameProd,
      nameBusns: nameBusns,
      imgUrl: imgUrlProd,
      reducRate: reducRate * 100,
      delivDuration: delivDuration,
      price: price,
      priceWithReduc: getPriceWithReduction(price, reducRate),
    );
  }
}
