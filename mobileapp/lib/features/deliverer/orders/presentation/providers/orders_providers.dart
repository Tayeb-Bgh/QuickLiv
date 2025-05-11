import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/deliverer/orders/business/entities/order_entity.dart';
import 'package:mobileapp/features/deliverer/orders/business/repositories/orders_repo.dart';
import 'package:mobileapp/features/deliverer/orders/business/usecases/get_orders.dart';
import 'package:mobileapp/features/deliverer/orders/data/repositories/orders_repo_impl.dart';
import 'package:mobileapp/features/deliverer/orders/data/service/orders_service.dart';

final selectedCategoryIndexProvider = StateProvider<bool>((ref) => false);
final currentCardIndexProvider = StateProvider<int>((ref) => 0);
final mapViewProvider = StateProvider<MapViewType>(
  (ref) => MapViewType.business,
);
final getOrdersUseCaseProvider = Provider<GetOrders>((ref) {
  final repository = ref.watch(ordersRepositoryProvider);
  return GetOrders(repository);
});
final fetchOrdersProvider = FutureProvider<List<OrderEntity>>((ref) async {
  final getOrders = ref.watch(getOrdersUseCaseProvider);
  return await getOrders();
});
final ordersServiceProvider = Provider<OrdersService>((ref) {
  final dio =
      Dio(); // or ref.watch(dioProvider) if you're managing Dio elsewhere
  return OrdersService(dio: dio, ref: ref);
});

enum MapViewType { business, client }

final ordersRepositoryProvider = Provider<OrdersRepo>((ref) {
  final service = ref.watch(ordersServiceProvider);
  return OrdersRepoImpl(ordersService: service);
});
