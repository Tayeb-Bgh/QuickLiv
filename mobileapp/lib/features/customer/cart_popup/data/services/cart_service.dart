import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:mobileapp/core/utils/cart_box_utils.dart';
import 'package:mobileapp/features/customer/cart_popup/business/entities/business.dart';
import 'package:mobileapp/features/customer/cart_popup/business/entities/product_cart.dart';
import 'package:mobileapp/features/customer/cart_popup/data/models/cart_hive_object.dart';

import 'package:mobileapp/features/customer/cart_popup/data/models/product_hive_object.dart';

class CartService {
  Future<bool> addToCart(
    ProductCart productCart, {
    required Business busns,
    required Product product,
  }) async {
    final boxName = await CartBoxUtils.findAvailableCartBox(
      busns.idBusns.toString(),
    );

    if (boxName == null) {
      log('alll boxes are taken fo find new ones ');
      return false;
    }
    final box = Hive.box<Cart>(boxName);

    Cart? cart = box.get('cart');

    cart ??= Cart(
      prod: [],
      id: busns.idBusns.toString(),
      name: busns.nameBusns,
      delPrice: busns.delivPrice,
      pic: busns.imgUrl,
    );

    final existingProductIndex = cart.prod.indexWhere(
      (p) => p.id == product.id,
    );
    if (existingProductIndex != -1) {
      cart.prod[existingProductIndex].poidQuantity += product.poidQuantity;
    } else {
      cart.prod.add(product);
    }

    await box.put('cart', cart);
    return true;
  }

  static Future<void> clearCart(String commerceId) async {
    final boxName = await CartBoxUtils.findAvailableCartBox(commerceId);
    if (boxName == null) return;
    log('boxName deleted is : $boxName');
    final box = Hive.box<Cart>(boxName);
    await box.delete('cart');
  }

  Future<List<Cart>> getAllCarts() async {
    final carts = <Cart>[];
    const boxNames = [
      'cartBox1',
      'cartBox2',
      'cartBox3',
      'cartBox4',
      'cartBox5',
    ];

    for (final boxName in boxNames) {
      if (Hive.isBoxOpen(boxName)) {
        final cart = Hive.box<Cart>(boxName).get('cart');
        if (cart != null) {
          carts.add(cart);
        }
      }
    }

    return carts;
  }

  static Future<bool> deleteFromCard(String boxName, int idProd) async {
    final box = Hive.box<Cart>(boxName);
    final cart = box.get('cart');
    log('u are in deleting function');
    if (cart == null) return false;

    final initialLength = cart.prod.length;
    cart.prod.removeWhere((p) => p.id == idProd.toString());

    if (cart.prod.length != initialLength) {
      await box.put('cart', cart);
      log('Product deleted successfully from cart.');
      return true;
    } else {
      log('there is an error while deleting');
    }

    return false;
  }

  static Future<void> updateProduct({
    required String boxName,
    required String productId,
    int? quantity,
    String? notice,
  }) async {
    try {
      final box = Hive.box<Cart>(boxName);
      final cart = box.get('cart');

      if (cart == null) {
        log('No cart found in box $boxName.');
        return;
      }

      final index = cart.prod.indexWhere((p) => p.id.toString() == productId);
      if (index == -1) {
        log('Product not found in cart.');
        return;
      }
      if (quantity != null) {
        cart.prod[index].poidQuantity = quantity;
      } else {
        log('the notice is updated here');
        cart.prod[index].notice = notice;
        log(cart.prod[index].notice ?? 'its empty');
      }
      await box.put('cart', cart);
      log('Product updated successfully in cart.');
    } catch (e) {
      log('An error occurred while updating product: $e');
    }
  }
}
