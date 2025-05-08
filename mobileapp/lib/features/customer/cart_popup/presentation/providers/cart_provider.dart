import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/customer/cart_popup/business/entities/cart_entity.dart';
import 'package:mobileapp/features/customer/cart_popup/business/usecases/get_carts.dart';

import 'package:mobileapp/features/customer/cart_popup/data/repositories/cart_repo_impl.dart';
import 'package:mobileapp/features/customer/cart_popup/data/services/cart_service.dart';
import 'package:mobileapp/features/customer/cart_popup/business/usecases/add_to_cart.dart';

final addToCartUseCaseProvider = Provider<AddToCart>((ref) {
  final cartRepo = ref.watch(cartRepoProvider);
  return AddToCart(cartRepo, ref);
});

final cartServiceProvider = Provider<CartService>((ref) {
  return CartService();
});

final cartRepoProvider = Provider<CartRepoImpl>((ref) {
  final cartService = ref.watch(cartServiceProvider);
  return CartRepoImpl(cartService: cartService);
});

final cartsProvider =
    StateNotifierProvider<CartNotifier, AsyncValue<List<Cart>>>((ref) {
      final repo = ref.watch(cartRepoProvider);
      return CartNotifier(repo);
    });

class CartNotifier extends StateNotifier<AsyncValue<List<Cart>>> {
  final CartRepoImpl cartRepo;

  CartNotifier(this.cartRepo) : super(const AsyncValue.loading()) {
    _loadCarts();
  }

  Future<void> _loadCarts() async {
    try {
      final carts = await GetCarts(cartRepo).call();
      state = AsyncValue.data(carts);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> reload() async {
    state = const AsyncValue.loading();
    await _loadCarts();
    log("State after reload: $state");
  }
}
