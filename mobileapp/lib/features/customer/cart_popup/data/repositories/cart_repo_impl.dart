import 'dart:developer';

import 'package:mobileapp/features/customer/cart_popup/business/entities/business.dart';
import 'package:mobileapp/features/customer/cart_popup/business/entities/cart_entity.dart';
import 'package:mobileapp/features/customer/cart_popup/business/entities/product_cart.dart';
import 'package:mobileapp/features/customer/cart_popup/business/repositories/cart_repo.dart';
import 'package:mobileapp/features/customer/cart_popup/data/services/cart_service.dart';
import 'package:mobileapp/features/customer/cart_popup/data/models/product_hive_object.dart';
import 'package:mobileapp/features/customer/cart_popup/data/models/cart_hive_object.dart'
    as cart_hive_object;

class CartRepoImpl implements CartRepo {
  CartService cartService;
  CartRepoImpl({required this.cartService});
  @override
  Future<bool> addToCart(
    Business busns,
    ProductCart productCart,
    int quantity,
  ) {
    Product product = Product(
      descr: productCart.description,
      nom: productCart.name,
      id: productCart.id.toString(),
      pic: productCart.imgUrl,
      poidQuantity: quantity,
      prix: productCart.price,
      unitProd: productCart.unitProd,
    );
    log(
      'product is rep imp is working just fine and to prove this to u : ${product.id}',
    );

    return cartService.addToCart(productCart, busns: busns, product: product);
  }

  @override
  Future<List<Cart>> getAllCarts() async {
    final List<cart_hive_object.Cart> cartsAsync =
        await cartService.getAllCarts();
    final List<Cart> carts =
        cartsAsync.map((cart) {
          return Cart(
            prodPrice: _calculateTotProducts(cart.prod),
            idBusns: int.parse(cart.id),
            nameBusns: cart.name,
            delivPrice: cart.delPrice,
            imgUrl: cart.pic,
            products:
                cart.prod.map((product) {
                  return ProductCart(
                    id: int.parse(product.id),
                    description: product.descr,
                    name: product.nom,
                    imgUrl: product.pic,
                    quantity: product.poidQuantity,
                    price: product.prix,
                    unitProd: product.unitProd,
                    notice: product.notice ?? '',
                  );
                }).toList(),
          );
        }).toList();
    return carts;
  }

  _calculateTotProducts(List<Product> prod) {
    double total = 0.0;
    for (var element in prod) {
      if (element.unitProd) {
        total += (element.prix * (element.poidQuantity / 1000));
      } else {
        total += element.prix * element.poidQuantity;
      }
    }
    return total;
  }
}
