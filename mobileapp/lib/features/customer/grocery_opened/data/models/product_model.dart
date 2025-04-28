import 'package:mobileapp/core/utils/utility_functions.dart';
import 'package:mobileapp/features/customer/grocery_opened/business/entities/product_entity.dart';

class ProductModel {
  final int idProd;
  final String nameProd;
  final String categoryProd;
  final String secondCategoryProd;
  final String descProd;
  final String imgUrlProd;
  final bool unitProd;

  ProductModel({
    required this.idProd,
    required this.nameProd,
    required this.categoryProd,
    required this.secondCategoryProd,
    required this.descProd,
    required this.imgUrlProd,
    required this.unitProd,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      idProd: json["idProd"],
      nameProd: json["nameProd"],
      categoryProd: json["categoryProd"],
      secondCategoryProd: json["secondCategoryProd"],
      descProd: json["descProd"],
      imgUrlProd: json["imgUrlProd"],
      unitProd: json["unitProd"] == 1 ? true : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idProd": idProd,
      "nameProd": nameProd,
      "categoryProd": categoryProd,
      "secondCategoryProd": secondCategoryProd,
      "descProd": descProd,
      "imgUrlProd": imgUrlProd,
      "unitProd": unitProd == true ? 1 : 0,
    };
  }

  Product toEntity(
    int idBusns,
    double price,
    bool unit,
    double? reducRate,
    int? stockQtty,
  ) {
    return Product(
      idProd: idProd,
      idBusns: idBusns,
      name: nameProd,
      description: descProd,
      category: categoryProd,
      secondCategory: secondCategoryProd,
      imgUrl: imgUrlProd,
      unit: unit,
      reducRate: reducRate,
      price: price,
      priceWithReduc:
          reducRate != null ? getPriceWithReduction(price, reducRate) : null,
      stockQtty: stockQtty,
    );
  }
}
