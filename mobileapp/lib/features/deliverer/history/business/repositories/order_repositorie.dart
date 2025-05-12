import '../entities/order_entitie.dart';

abstract class DeliveryRepository {
  Future<List<Order>> getDelivererOrders();
  Future<CompleteOrder?> getCompleteOrder();
  Future<Customer?> getCustomerInfoByCartId();
  Future<Business?> getBusinessInfo();
  Future<List<Product>> getProductsByCartId();
}
