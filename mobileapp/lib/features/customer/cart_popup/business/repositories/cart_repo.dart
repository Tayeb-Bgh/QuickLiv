import 'package:mobileapp/features/customer/cart_popup/business/entities/business.dart';
import 'package:mobileapp/features/customer/cart_popup/business/entities/cart_entity.dart';
import 'package:mobileapp/features/customer/cart_popup/business/entities/product_cart.dart';

abstract class CartRepo {
  Future<void> addToCart(Business busns, ProductCart productCart, int quantity);
  Future<List<Cart>> getAllCarts();
}
