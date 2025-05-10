import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/auth/presentation/providers/auth_provider.dart';
import 'package:mobileapp/features/customer/orders/business/entities/order_entity.dart';
import 'package:mobileapp/features/customer/orders/business/get_orders_usecase.dart';
import 'package:mobileapp/features/customer/orders/data/orders_service.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

// Provider pour le OrdersService
final ordersServiceProvider = Provider<OrdersService>((ref) {
  final dio = ref.watch(dioProvider);
  return OrdersService(dio);
});

final ordersProvider = Provider<List<Order>>((ref) {
  return getMockOrders();
});

final customerFullOrdersProvider = FutureProvider.autoDispose<List<Order>>((
  ref,
) async {
  final ordersService = ref.watch(ordersServiceProvider);
  final secureStorage = ref.watch(secureStorageProvider);

  // Récupération du token
  final token = await secureStorage.read(key: "authToken");
  if (token == null) {
    throw Exception('No authentication token found');
  }

  // 1. Récupérer les IDs des commandes
  final orderIds = await ordersService.getCustomerOrderIds(token);
  log("le nombre d id : ${orderIds.length}");
  // 2. Pour chaque ID, récupérer les détails complets
  final orders = await Future.wait(
    orderIds.map((id) => ordersService.getOrderDetails(id)),
  );
  log("le nombre d oooooordre : ${orders.length}");
  return orders;
});
