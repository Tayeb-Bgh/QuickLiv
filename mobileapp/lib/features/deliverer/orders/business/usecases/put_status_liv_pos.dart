import 'package:mobileapp/features/deliverer/orders/business/repositories/orders_repo.dart';

class PutStatusLivPos {
 
  final OrdersRepo repository;

  PutStatusLivPos(this.repository);

  Future<void> call(int idOrd, String status,double lan , double lng) async {
    await repository.updateStatusLatLng(idOrd, status,lan,lng);
  }
}
