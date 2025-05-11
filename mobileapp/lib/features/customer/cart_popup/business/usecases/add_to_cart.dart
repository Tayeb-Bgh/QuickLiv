import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/utils/cart_box_utils.dart';
import 'package:mobileapp/features/customer/cart_popup/business/entities/business.dart';
import 'package:mobileapp/features/customer/cart_popup/business/entities/product_cart.dart'
    as product_card;
import 'package:mobileapp/features/customer/cart_popup/data/repositories/cart_repo_impl.dart';

class AddToCart {
  final CartRepoImpl cartRepoImpl;
  final Ref ref;
  AddToCart(this.cartRepoImpl, this.ref);

  Future<bool> call(
    product_card.ProductCart productCart,
    int quantity,
    int idBusns,
  ) async {
    Future<Business> busns = CartBoxUtils.findBusinessById(idBusns, ref);
    try {
      log('this log is for the usecase  $quantity');
      return cartRepoImpl.addToCart(await busns, productCart, quantity);
    } catch (e) {
      rethrow;
    }
  }
}
