import 'package:mobileapp/features/deliverer/orders/business/entities/order_entity.dart';

import '../../../../auth/business/entities/deliverer_entity.dart';

abstract class OrdersRepo {
  Future<List<OrderEntity>> fetchAllOrders();
}
