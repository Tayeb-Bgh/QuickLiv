import 'package:mobileapp/features/customer/restaurant_opened/business/entities/product_entity.dart';


class ProductModel {
  final int idProd;
  final String categoryProd;
  final String nameProd;
  final String descProd;
  final String imgUrlProd;
  final double priceProd;
  final double? reducProd;

  ProductModel({
    required this.idProd,
    required this.nameProd,
    required this.categoryProd,
    required this.descProd,
    required this.imgUrlProd,
    required this.priceProd,
    this.reducProd,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
  return ProductModel(
    idProd: json["idProd"],
    nameProd: json["nameProd"],
    categoryProd: json["secondCategoryProd"], // <- ici
    descProd: json["descProd"],
    imgUrlProd: json["imgUrlProd"],
    priceProd: json["priceProdBusns"]?.toDouble() ?? 0.0, // <- ici
    reducProd: json["reducRateProdBusns"]?.toDouble(), // <- ici
  );
}


  Map<String, dynamic> toJson() {
    return {
      "idProd": idProd,
      "categoryProd": categoryProd,
      "descProd": descProd,
      "imgUrlProd": imgUrlProd,
    };
  }

  Product toEntity() {
    return Product(
      id: idProd,
      category: categoryProd,
      name: nameProd,
      desc: descProd,
      imgUrl: imgUrlProd,
      price: priceProd,
      priceWithReduc: reducProd == null ? null : Product.calculPriceWithReduc(priceProd, reducProd ?? 0),
    );
  }


  String toStringg() {
    return 'ProductModel{idProd: $idProd, categoryProd: $categoryProd, nameProd: $nameProd, descProd: $descProd, imgUrlProd: $imgUrlProd, priceProd: $priceProd, reducProd: $reducProd}';
  }
  
  }
