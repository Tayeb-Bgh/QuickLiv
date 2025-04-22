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
    int unitProd = json["unitProd"];
    bool unitProdBool = unitProd == 0 ? false : true;
    return ProductModel(
      idProd: json["idProd"],
      nameProd: json["nameProd"],
      imgUrlProd: json["imgUrlProd"],
      unitProd: unitProdBool,
    );
  }

  Map<String, dynamic> toJson() {
    int unit = unitProd == false ? 0 : 1;
    return {
      "idProd": idProd,
      "nameProd": nameProd,
      "imgUrlProd": imgUrlProd,
      "unitProd": unit,
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
