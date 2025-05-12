import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/deliverer/history/business/entities/order_entitie.dart';
import 'package:mobileapp/features/deliverer/history/presentation/providers/deliverer_history_provider.dart';

final selectedFilterProvider = StateProvider<String?>((ref) => 'Toutes');

final filteredOrdersProvider = Provider<List<CompleteOrder>>((ref) {
  final selectedFilter = ref.watch(selectedFilterProvider);
  final completeOrders = ref.watch(completeOrdersProvider).completeOrders;

  if (selectedFilter == null || selectedFilter == 'Toutes') {
    return completeOrders;
  }

  return completeOrders.where((order) {
    if (selectedFilter == 'Livrées') {
      return order.order.cancelComment.isEmpty;
    } else if (selectedFilter == 'Annulées') {
      return order.order.cancelComment.isNotEmpty;
    }
    return false;
  }).toList();
});
