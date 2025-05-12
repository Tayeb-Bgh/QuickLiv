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

  //log("RECUPERATION DU TOKEN ...");
  final token = await secureStorage.read(key: "authToken");
  if (token == null) {
    throw Exception('No authentication token found');
  }

  //log("RECUPERATION DU TOKEN FINI");

  // 1. Récupérer les IDs des commandes
  //log("RECUPERATION DES ORDER IDS ...");
  final orderIds = await ordersService.getCustomerOrderIds(token);
  //log("RECUPERATION DES ORDER IDS FINI");

  // 2. Pour chaque ID, récupérer les détails complets
  //log("RECUPERATION DES ORDERS ...");
  final orders = await Future.wait(
    orderIds.map((id) => ordersService.getOrderDetails(id)),
  );
  //log("RECUPERATION DES ORDERS FINI");
  //log("le nombre d ordres : ${orders.length}");
  return orders;
});
