import 'package:mobileapp/features/deliverer/orders/business/entities/product_entity.dart';

class ProductInOrder {
  final int idProd;
  final String nameProd;
  final double unitPriceProdCart;
  final int qttyProdCart;
  final bool unitProd;

  ProductInOrder({
    required this.idProd,
    required this.nameProd,
    required this.unitPriceProdCart,
    required this.qttyProdCart,
    required this.unitProd,
  });

  factory ProductInOrder.fromJson(Map<String, dynamic> json) {
    return ProductInOrder(
      idProd: json['idProd'],
      nameProd: json['nameProd'],
      unitPriceProdCart: (json['unitPriceProdCart'] as num?)?.toDouble() ?? 0.0,
      qttyProdCart: json['qttyProdCart'],
      unitProd:
          json['unitProd'] is bool ? json['unitProd'] : (json['unitProd'] == 1),
    );
  }

  Product toEntity() {
    return Product(
      id: idProd,
      name: nameProd,
      price: unitPriceProdCart,
      quantity: qttyProdCart,
      unitProd: unitProd,
    );
  }
}
