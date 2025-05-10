import 'package:mobileapp/features/customer/cart_popup/business/entities/product_cart.dart';

class Cart {
  final int idBusns;
  final double delivPrice;
  final String nameBusns;
  final String imgUrl;
  final double prodPrice;
  final List<ProductCart> products;
  final double totalPrice = 0.0;
  Cart({
    required this.idBusns,
    required this.delivPrice,
    required this.nameBusns,
    required this.imgUrl,
    required this.prodPrice,
    required this.products,
  });

  Map<String, dynamic> toJson() {
    return {"idBusnsCart": idBusns};
  }
}
