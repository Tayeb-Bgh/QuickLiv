import 'package:mobileapp/features/deliverer/history/data/service/order_service.dart';
import '../../business/entities/order_entitie.dart';

class OrderRepositoryImpl {
  final RemoteDataSource remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  Future<List<CompleteOrder>> getCompleteOrders() async {
    try {
      final completeOrderModels = await remoteDataSource.fetchCompleteOrders();

      return completeOrderModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Error while retrieving the complete orders: $e');
    }
  }
}
