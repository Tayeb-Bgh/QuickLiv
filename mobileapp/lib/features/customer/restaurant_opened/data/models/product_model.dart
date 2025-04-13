import 'package:mobileapp/features/customer/restaurant_opened/business/entities/product_entity.dart';


class ProductModel {
  final int idProd;
  final String barCodeProd;
  final String categoryProd;
  final String descProd;
  final bool unitProd;
  final String imgUrlProd;
  final bool byAdminProd;
  final bool deleteProd;

  ProductModel({
    required this.idProd,
    required this.barCodeProd,
    required this.categoryProd,
    required this.descProd,
    required this.unitProd,
    required this.imgUrlProd,
    required this.byAdminProd,
    required this.deleteProd,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      idProd: json["idProd"],
      barCodeProd: json["barCodeProd"],
      categoryProd: json["categoryProd"],
      descProd: json["descProd"],
      unitProd: json["unitProd"],
      imgUrlProd: json["imgUrlProd"],
      byAdminProd: json["byAdminProd"],
      deleteProd: json["deleteProd"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idProd": idProd,
      "barCodeProd": barCodeProd,
      "categoryProd": categoryProd,
      "descProd": descProd,
      "unitProd": unitProd,
      "imgUrlProd": imgUrlProd,
      "byAdminProd": byAdminProd,
      "deleteProd": deleteProd,
    };
  }

  Product toEntity(double price, double reduc) {
    return Product(
      id: idProd,
      category: categoryProd,
      desc: descProd,
      imgUrl: imgUrlProd,
      price: price,
      priceWithReduc: Product.calculPriceWithReduc(price, reduc),
    );
  }
}
