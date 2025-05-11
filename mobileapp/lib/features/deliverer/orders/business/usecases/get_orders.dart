import 'package:mobileapp/features/deliverer/orders/business/entities/order_entity.dart';
import 'package:mobileapp/features/deliverer/orders/business/repositories/orders_repo.dart';

class GetOrders {
  final OrdersRepo repository;

  GetOrders(this.repository);

  Future<List<OrderEntity>> call() async {
    return await repository.fetchAllOrders();
  }
}
