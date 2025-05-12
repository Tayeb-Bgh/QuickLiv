import 'package:mobileapp/features/deliverer/orders/business/entities/order_entity.dart';

import '../../../../auth/business/entities/deliverer_entity.dart';

abstract class OrdersRepo {
  Future<List<OrderEntity>> fetchAllOrders();
  Future<OrderEntity?> fetchCurrentOrder();
  Future<void> assignOrder(int orderId);
  Future<void> updateStatus(int idOrd, String status );
  Future<void> updateStatusLatLng(int idOrd , String status , double lan , double lng );
}
