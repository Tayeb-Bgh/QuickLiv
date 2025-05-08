import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/customer/orders/business/entities/order_entity.dart';
import 'package:mobileapp/features/customer/orders/business/get_orders_usecase.dart';

final ordersProvider = Provider<List<Order>>((ref) {
  return getMockOrders();
});
