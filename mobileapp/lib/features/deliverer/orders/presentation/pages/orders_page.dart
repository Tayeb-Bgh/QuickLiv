import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/deliverer/orders/presentation/providers/orders_providers.dart';
import 'package:mobileapp/features/deliverer/orders/presentation/widgets/at_business_card.dart';
import 'package:mobileapp/features/deliverer/orders/presentation/widgets/at_client_card.dart';
import 'package:mobileapp/features/deliverer/orders/presentation/widgets/business_rendezvous_card.dart';
import 'package:mobileapp/features/deliverer/orders/presentation/widgets/buttons_row.dart';
import 'package:mobileapp/features/deliverer/orders/presentation/widgets/order_widget.dart';
import 'package:mobileapp/features/deliverer/orders/presentation/widgets/to_client_card.dart';

class OrdersPage extends ConsumerWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialise les mises à jour temps réel
    ref.read(realTimeOrdersProvider);

    final selectedIndex = ref.watch(selectedCategoryIndexProvider);
    final isDarkMode = ref.watch(darkModeProvider);
    final fontColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    final backgroundColor = isDarkMode ? kPrimaryBlack : kPrimaryWhite;
    final currentIndex = ref.watch(currentCardIndexProvider);
    final height = MediaQuery.sizeOf(context).height;

    // Utilise la liste synchronisée en temps réel
    final orders = ref.watch(ordersListProvider);
    final ordersAsync = ref.watch(fetchOrdersProvider);

    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            HorizontalRadioButtons(),
            SizedBox(height: height * 0.02),
            selectedIndex
                ? Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => ref.refresh(fetchOrdersProvider.future),
                    child: ordersAsync.when(
                      data:
                          (_) => ListView.builder(
                            itemCount: orders.length,
                            itemBuilder: (context, index) {
                              return OrderWidget(
                                order: orders[index],
                                ref: ref,
                              );
                            },
                          ),
                      loading:
                          () =>
                              const Center(child: CircularProgressIndicator()),
                      error: (err, stack) => Center(child: Text('Error: $err')),
                    ),
                  ),
                )
                : Expanded(child: _buildCard(ref, currentIndex)),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(WidgetRef ref, int index) {
    final notifier = ref.read(currentCardIndexProvider.notifier);

    switch (index) {
      case 0:
        return BusinessRendezvousCard(onNext: () => notifier.state++);
      case 1:
        return AtBusinessCard(onNext: () => notifier.state++);
      case 2:
        return ToClientCard(onNext: () => notifier.state++);
      case 3:
        return AtClientCard(reset: () => notifier.state = 0);
      default:
        return Container();
    }
  }
}
