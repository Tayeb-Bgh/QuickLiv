import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/orders/presentation/pages/order_delivered_page.dart';
import 'package:mobileapp/features/customer/orders/presentation/pages/order_in_progress_page.dart';
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
      body: Container(
        color: isDarkMode ? kPrimaryDark : kSecondaryWhite,
        child: Column(
          children: [
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => setState(() => showOld = false),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: !showOld ? kPrimaryRed : Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: kPrimaryRed, width: 2),
                    ),
                    child: Text(
                      'En cours',
                      style: TextStyle(
                        color:
                            isDarkMode
                                ? (!showOld ? kPrimaryWhite : kPrimaryWhite)
                                : (!showOld ? kPrimaryWhite : kPrimaryRed),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () => setState(() => showOld = true),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: showOld ? kPrimaryRed : Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: kPrimaryRed, width: 2),
                    ),
                    child: Text(
                      'Anciennes',
                      style: TextStyle(
                        color:
                            isDarkMode
                                ? (!showOld ? kPrimaryWhite : kPrimaryWhite)
                                : (!showOld ? kPrimaryRed : kPrimaryWhite),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: filteredOrders.length,
                itemBuilder:
                    (_, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) =>
                                    filteredOrders[index].status == 4
                                        ? OrderDeliveredPage(
                                          order: filteredOrders[index],
                                        )
                                        : OrderDetailsPage(
                                          order: filteredOrders[index],
                                        ),
                          ),
                        );
                      },
                      child: OrderCard(order: filteredOrders[index]),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
