import 'package:mobileapp/features/auth/business/entities/deliverer_entity.dart';
import 'package:mobileapp/features/deliverer/orders/business/entities/order_entity.dart';
import 'package:mobileapp/features/deliverer/orders/business/entities/product_entity.dart';
import 'package:mobileapp/features/deliverer/orders/business/repositories/orders_repo.dart';
import 'package:mobileapp/features/deliverer/orders/data/service/orders_service.dart';

class OrdersRepoImpl extends OrdersRepo {
  final OrdersService ordersService;

  OrdersRepoImpl({required this.ordersService});
  @override
  Future<List<OrderEntity>> fetchAllOrders() async {
    final orderModels = await ordersService.fetchAllOrders();
    final orders =
        orderModels.map((orderModel) => orderModel.toEntity()).toList();
    for (var order in orders) {
      final productsInOrder = await ordersService.fetchProductsForOrder(
        order.id,
      );
      order.products = productsInOrder.map((p) => p.toEntity()).toList();
      order.totalPrice = _calculateTotal(order.products);
    }
    return orders;
  }

  double _calculateTotal(List<Product> products) {
    return products.fold(
      0.0,
      (total, product) =>
          total +
          (product.unitProd
              ? (product.price * product.quantity / 1000)
              : (product.price * product.quantity)),
    );
  }
}
