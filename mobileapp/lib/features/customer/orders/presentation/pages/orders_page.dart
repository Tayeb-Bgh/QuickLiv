import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/orders/presentation/providers/orders_provider.dart';
import 'package:mobileapp/features/customer/orders/presentation/widgets/order_card_widget.dart';

class OrdersPage extends ConsumerStatefulWidget {
  const OrdersPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<OrdersPage> {
  bool showOld = false;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ref.watch(darkModeProvider);
    final orders = ref.watch(ordersProvider);

    final filteredOrders =
        orders.where((o) {
          if (showOld) {
            return o.status == 4;
          } else {
            return o.status != 4;
          }
        }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryRed,
        centerTitle: true,
        foregroundColor: kPrimaryWhite,
        title: const Text('Mes commandes'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                label: const Text('En Cours'),
                selected: !showOld,
                onSelected: (_) => setState(() => showOld = false),
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text('Anciennes'),
                selected: showOld,
                onSelected: (_) => setState(() => showOld = true),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: filteredOrders.length,
              itemBuilder:
                  (_, index) => OrderCard(order: filteredOrders[index]),
            ),
          ),
        ],
      ),
    );
  }
}
