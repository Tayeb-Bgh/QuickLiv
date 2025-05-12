import 'package:mobileapp/features/deliverer/orders/business/repositories/orders_repo.dart';

class PutStatus {
 
  final OrdersRepo repository;

  PutStatus(this.repository);

  Future<void> call(int idOrd, String status) async {
    await repository.updateStatus(idOrd, status);
  }
}

