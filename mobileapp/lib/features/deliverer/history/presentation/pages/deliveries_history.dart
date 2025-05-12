import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/features/deliverer/history/presentation/widgets/buttons_row.dart';
import 'package:mobileapp/features/deliverer/history/presentation/widgets/history_commad.dart';
import 'package:mobileapp/features/deliverer/history/presentation/providers/deliverer_history_provider.dart';
import 'package:mobileapp/features/deliverer/history/presentation/providers/filter_provider.dart';

class DeliveriesHistory extends ConsumerStatefulWidget {
  const DeliveriesHistory({super.key});

  @override
  ConsumerState<DeliveriesHistory> createState() => _DeliveriesHistoryState();
}

class _DeliveriesHistoryState extends ConsumerState<DeliveriesHistory> {
  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(completeOrdersProvider.notifier).fetchCompleteOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final completeOrdersState = ref.watch(completeOrdersProvider);
    final filteredOrders = ref.watch(filteredOrdersProvider);
    final isDarkMode = true;
    debugPrint(isDarkMode.toString());
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            height: height * 0.70,
            child:
                completeOrdersState.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : completeOrdersState.errorMessage != null
                    ? Center(
                      child: Text(
                        completeOrdersState.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                    : filteredOrders.isEmpty
                    ? const Center(child: Text('Aucune commande trouvée'))
                    : ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 10),
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, index) {
                        final order = filteredOrders[index];
                        return HistoryCommand(
                          orderNumber: order.order.idOrd,
                          imgUrl: order.business.imageUrl,
                          items:
                              order.products
                                  .map(
                                    (product) => OrderItem2(
                                      name: product.name,
                                      quantity: product.quantity,
                                      unite: product.unite,
                                    ),
                                  )
                                  .toList(),
                          restaurantName: order.business.name,
                          status: order.order.cancelComment,
                          date:
                              '${order.order.createdAt.day}-${order.order.createdAt.month}-${order.order.createdAt.year}',
                          personName:
                              '${order.customer.firstName} ${order.customer.lastName}',
                          locaComm: order.business.address,
                          price:
                              '${order.order.deliveryPrice.toStringAsFixed(2)} DA',
                          totalPrice:
                              '${order.totalAmount.toStringAsFixed(2)} DA',
                          paymentMethod: order.order.transactionNumber,
                          heure:
                              '${order.order.createdAt.hour}:${order.order.createdAt.minute.toString().padLeft(2, '0')}',
                          location: order.business.address,
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
