import 'package:mobileapp/features/customer/restaurants/business/entities/product_entity.dart';

class ProductModel {
  final int idProd;
  final String nameProd;
  final String imgUrlProd;
  final String descProd;
  final bool unitProd;

  ProductModel({
    required this.idProd,
    required this.nameProd,
    required this.imgUrlProd,
    required this.unitProd,
    required this.descProd,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    int unitProd = json["unitProd"];
    bool unitProdBool = unitProd == 0 ? false : true;
    return ProductModel(
      idProd: json["idProd"],
      nameProd: json["nameProd"],
      imgUrlProd: json["imgUrlProd"],
      descProd: json["descProd"],
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
      "descProd": descProd,
    };
  }

  Product toEntity(
    int idBusns,
    String nameBusns,
    double price,
    int delivDuration,
  ) {
    return Product(
      idProd: idProd,
      idBusns: idBusns,
      nameProd: nameProd,
      nameBusns: nameBusns,
      imgUrl: imgUrlProd,
      delivDuration: delivDuration,
      price: price,
      description: descProd,
    );
  }
}
