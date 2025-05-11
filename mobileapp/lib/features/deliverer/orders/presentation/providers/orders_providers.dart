import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/deliverer/orders/business/entities/order_entity.dart';
import 'package:mobileapp/features/deliverer/orders/business/repositories/orders_repo.dart';
import 'package:mobileapp/features/deliverer/orders/business/usecases/get_orders.dart';
import 'package:mobileapp/features/deliverer/orders/data/repositories/orders_repo_impl.dart';
import 'package:mobileapp/features/deliverer/orders/data/service/orders_service.dart';
import 'package:mobileapp/features/deliverer/orders/presentation/pages/socket.dart';

final selectedCategoryIndexProvider = StateProvider<bool>((ref) => false);
final currentCardIndexProvider = StateProvider<int>((ref) => 0);
final mapViewProvider = StateProvider<MapViewType>(
  (ref) => MapViewType.business,
);

// Providers existants
final getOrdersUseCaseProvider = Provider<GetOrders>((ref) {
  final repository = ref.watch(ordersRepositoryProvider);
  return GetOrders(repository);
});

final fetchOrdersProvider = FutureProvider<List<OrderEntity>>((ref) async {
  final getOrders = ref.watch(getOrdersUseCaseProvider);
  final orders = await getOrders();
  ref.read(ordersListProvider.notifier).updateAll(orders);
  return orders;
});

final ordersServiceProvider = Provider<OrdersService>((ref) {
  final dio = Dio(); // ou ref.watch(dioProvider) si vous gérez Dio ailleurs
  return OrdersService(dio: dio, ref: ref);
});

enum MapViewType { business, client }

final ordersRepositoryProvider = Provider<OrdersRepo>((ref) {
  final service = ref.watch(ordersServiceProvider);
  return OrdersRepoImpl(ordersService: service);
});

// Providers pour la gestion temps réel
final socketServiceProvider = Provider<SocketService>((ref) {
  final service = SocketService();
  ref.onDispose(() => service.disconnect());
  return service;
});

final ordersListProvider =
    StateNotifierProvider<OrdersListNotifier, List<OrderEntity>>((ref) {
      return OrdersListNotifier();
    });

class OrdersListNotifier extends StateNotifier<List<OrderEntity>> {
  OrdersListNotifier() : super([]);

  void updateAll(List<OrderEntity> orders) {
    state = orders;
  }

  void removeOrders(List<int> orderIds) {
    state = state.where((order) => !orderIds.contains(order.id)).toList();
  }
}

final realTimeOrdersProvider = Provider<void>((ref) {
  final socket = ref.read(socketServiceProvider);
  final ordersNotifier = ref.read(ordersListProvider.notifier);

  socket.joinDelivererRoom();

  // Rafraîchir toute la liste quand de nouvelles commandes arrivent
  socket.listenForNewOrders(() {
    log("Je vais reload lhala");
    ref.invalidate(fetchOrdersProvider); // Force le rafraîchissement
  });

  // Supprimer les commandes prises par d'autres livreurs
  socket.listenForRemovedOrders((removedIds) {
    log("je vais reload apres sup");
    ref.invalidate(fetchOrdersProvider);
    ordersNotifier.removeOrders(removedIds.cast<int>());
  });
});
