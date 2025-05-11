import 'package:mobileapp/features/customer/research/business/entities/product_entity.dart';

class ProductModel {
  final int idProd;
  final String nameProd;
  final String categoryProd;
  final String secondCategoryProd;
  final String imgUrlProd;
  final bool unitProd;
  final String descProd;
  ProductModel({
    required this.idProd,
    required this.nameProd,
    required this.categoryProd,
    required this.secondCategoryProd,
    required this.imgUrlProd,
    required this.unitProd,
    required this.descProd,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      idProd: json["idProd"],
      descProd: json["descProd"],
      nameProd: json["nameProd"],
      categoryProd: json["categoryProd"],
      secondCategoryProd: json["secondCategoryProd"],
      imgUrlProd: json["imgUrlProd"],
      unitProd: json["unitProd"] == 1 ? true : false,
    );
  }

  Product toEntity(
    int idBusns,
    double price,
    double? reducRate,
    int? qttyStock,
  ) {
    return Product(
      idProd: idProd,
      descr: descProd,
      idBusns: idBusns,
      name: nameProd,
      imgUrl: imgUrlProd,
      price: price,
      qttyStock: qttyStock,
      reducRate: reducRate,
      unit: unitProd,
    );
  }
}
