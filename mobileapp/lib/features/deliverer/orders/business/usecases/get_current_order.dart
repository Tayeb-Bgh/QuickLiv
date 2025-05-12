import 'package:mobileapp/features/deliverer/orders/business/entities/order_entity.dart';
import 'package:mobileapp/features/deliverer/orders/business/repositories/orders_repo.dart';

class GetCurrentOrder {
  final OrdersRepo repository;

  GetCurrentOrder(this.repository);

  Future<OrderEntity?> call() async {
    return await repository.fetchCurrentOrder();
  }
}
