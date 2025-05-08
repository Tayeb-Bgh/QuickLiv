import 'dart:developer';
import 'package:mobileapp/features/customer/cart_popup/business/entities/cart_entity.dart';
import 'package:mobileapp/features/customer/cart_popup/data/repositories/cart_repo_impl.dart';
import 'package:mobileapp/features/customer/cart_popup/data/services/cart_service.dart';

import 'package:mobileapp/features/customer/cart_popup/data/models/product_hive_object.dart';

class GetCarts {
  final CartRepoImpl cartRepoImpl;
  GetCarts(this.cartRepoImpl);
  Future<List<Cart>> call() async {
    try {
      final carts = await cartRepoImpl.getAllCarts();
      if (carts.isEmpty) {
        log('No carts found.');
      }
      log('Carts found: ${carts.length}');
     
      return carts;
    } catch (e) {
      rethrow;
    }
  }
}
