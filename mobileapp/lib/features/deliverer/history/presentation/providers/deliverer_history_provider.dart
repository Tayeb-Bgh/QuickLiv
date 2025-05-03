import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/deliverer/history/data/repositories/order_repositorie_impl.dart';
import 'package:mobileapp/features/deliverer/history/business/entities/order_entitie.dart';
import 'package:mobileapp/features/deliverer/history/data/service/order_service.dart';

final selectedFilterProvider = StateProvider<String?>((ref) => 'Toutes');

// final allDeliveriesProvider = StateProvider<List<Delivery>>
// final filteredDeliveriesProvider = Provider<List<Delivery>>((ref) {
//   final selectedFilter = ref.watch(selectedFilterProvider);
//   final allDeliveries = ref.watch(allDeliveriesProvider);

//   if (selectedFilter == null || selectedFilter == 'Toutes') {
//     return allDeliveries;
//   }

//   return allDeliveries
//       .where((delivery) => delivery.status == selectedFilter)
//       .toList();
// });

// Provider pour le RemoteDataSource
final remoteDataSourceProvider = Provider<RemoteDataSource>((ref) {
  const baseUrl = 'http://192.168.43.52:3000/api/deliverer';

  return RemoteDataSource(baseUrl);
});
// Provider pour le repository
final orderRepositoryProvider = Provider<OrderRepositoryImpl>((ref) {
  final remoteDataSource = ref.watch(remoteDataSourceProvider);

  return OrderRepositoryImpl(remoteDataSource);
});

final completeOrdersProvider =
    StateNotifierProvider<CompleteOrdersNotifier, CompleteOrdersState>((ref) {
      final repository = ref.watch(orderRepositoryProvider);
      return CompleteOrdersNotifier(repository);
    });

class CompleteOrdersState {
  final List<CompleteOrder> completeOrders;
  final bool isLoading;
  final String? errorMessage;

  CompleteOrdersState({
    this.completeOrders = const [],
    this.isLoading = false,
    this.errorMessage,
  });
}

class CompleteOrdersNotifier extends StateNotifier<CompleteOrdersState> {
  final OrderRepositoryImpl _repository;

  CompleteOrdersNotifier(this._repository) : super(CompleteOrdersState());

  Future<void> fetchCompleteOrders() async {
    state = CompleteOrdersState(isLoading: true);

    try {
      final completeOrders = await _repository.getCompleteOrders();
      state = CompleteOrdersState(completeOrders: completeOrders);
    } catch (e) {
      state = CompleteOrdersState(
        errorMessage: 'Error while fetching the orders: $e',
      );
    }
  }
}
