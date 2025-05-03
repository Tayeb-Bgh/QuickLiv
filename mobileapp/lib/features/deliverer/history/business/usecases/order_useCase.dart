import 'package:mobileapp/features/deliverer/history/business/entities/order_entitie.dart';
import 'package:mobileapp/features/deliverer/history/business/repositories/order_repositorie.dart';

class GetCompleteOrderUseCase {
  final DeliveryRepository repository;

  GetCompleteOrderUseCase(this.repository);

  Future<CompleteOrder?> execute() {
    return repository.getCompleteOrder();
  }
}

class GetCustomerInfoUseCase {
  final DeliveryRepository repository;

  GetCustomerInfoUseCase(this.repository);

  Future<Customer?> execute() {
    return repository.getCustomerInfoByCartId();
  }
}

class GetProductsUseCase {
  final DeliveryRepository repository;

  GetProductsUseCase(this.repository);

  Future<List<Product>> execute() {
    return repository.getProductsByCartId();
  }
}
