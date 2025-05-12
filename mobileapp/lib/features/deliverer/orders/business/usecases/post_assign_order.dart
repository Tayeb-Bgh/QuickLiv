
import 'package:mobileapp/features/deliverer/orders/business/repositories/orders_repo.dart';
class PostAssignOrder {
  final OrdersRepo repository;
  final int idOrd;
  PostAssignOrder(this.repository, this.idOrd);

  Future<void> call() async {
    return await repository.assignOrder(idOrd);
  }
}
