import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/deliverer/orders/business/entities/order_entity.dart';
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
    final isDarkMode = ref.watch(darkModeProvider);
    final fontColor = isDarkMode ? kPrimaryWhite : kPrimaryBlack;
    final backgroundColor = isDarkMode ? kPrimaryBlack : kPrimaryWhite;
    final height = MediaQuery.of(context).size.height;
    ref.read(realTimeOrdersProvider);
    final selectedIndex = ref.watch(selectedCategoryIndexProvider);
    final isTaken = ref.watch(isTakenProvider);
    final currentIndex = ref.watch(currentCardIndexProvider);
    final orders = ref.watch(ordersListProvider);
    final ordersAsync = ref.watch(fetchOrdersProvider);
    final currentOrderAsync = ref.watch(fetchCurrentOrderProvider);

    ref.listen(fetchCurrentOrderProvider, (previous, next) {
      next.whenData((order) {
        final takenNotifier = ref.read(isTakenProvider.notifier);
        final selectedNotifier = ref.read(
          selectedCategoryIndexProvider.notifier,
        );
        final currentCardNotifier = ref.read(currentCardIndexProvider.notifier);
        if (order != null) {
          takenNotifier.state = true;
          selectedNotifier.state = false;
          currentCardNotifier.state = order.status;
        } else {
          takenNotifier.state = false;
        }
      });
    });

    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const HorizontalRadioButtons(),
            SizedBox(height: height * 0.02),
            Expanded(
              child: _buildBody(
                ref: ref,
                isListSelected: selectedIndex,
                isTaken: isTaken,
                ordersAsync: ordersAsync,
                orders: orders,
                currentIndex: currentIndex,
                fontColor: fontColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody({
    required WidgetRef ref,
    required bool isListSelected,
    required bool isTaken,
    required AsyncValue ordersAsync,
    required List<OrderEntity> orders,
    required int currentIndex,
    required Color fontColor,
  }) {
    if (isListSelected) {
      if (isTaken) {
        return _buildMessageCard(
          icon: Icons.visibility_off,
          text:
              'Vous pourrez voir et prendre une autre commande une fois avoir fini celle actuel',
          fontColor: fontColor,
        );
      } else {
        return RefreshIndicator(
          onRefresh: () => ref.refresh(fetchOrdersProvider.future),
          child: ordersAsync.when(
            data:
                (_) => ListView.builder(
                  itemCount: orders.length,
                  itemBuilder:
                      (context, index) =>
                          OrderWidget(order: orders[index], ref: ref),
                ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error:
                (err, _) => Center(
                  child: Text(
                    'Erreur de chargement : $err',
                    style: TextStyle(color: fontColor),
                  ),
                ),
          ),
        );
      }
    } else {
      if (isTaken) {
        final currentOrder = ref
            .watch(fetchCurrentOrderProvider)
            .maybeWhen(data: (order) => order, orElse: () => null);

        if (currentOrder != null) {
          return _buildCurrentOrderCard(ref, currentIndex - 1, currentOrder);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      } else {
        return _buildMessageCard(
          icon: Icons.inbox,
          text:
              "Vous n'avez actuellement aucune commande en cours, vous pouvez en prendre une dans la liste des commandes en attente",
          fontColor: fontColor,
        );
      }
    }
  }

  Widget _buildMessageCard({
    required IconData icon,
    required String text,
    required Color fontColor,
  }) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 50, color: fontColor),
          const SizedBox(height: 12),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: fontColor, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentOrderCard(WidgetRef ref, int index, OrderEntity order) {
    final indexNotifier = ref.read(currentCardIndexProvider.notifier);

    void resetOrderState() {
      ref.invalidate(fetchCurrentOrderProvider);
      ref.invalidate(fetchOrdersProvider);
      ref.read(selectedCategoryIndexProvider.notifier).state = true;
      ref.read(isTakenProvider.notifier).state = false;
    }

    switch (index) {
      case 0:
        return BusinessRendezvousCard(
          order: order,
          onNext: () => indexNotifier.state++,
        );
      case 1:
        return AtBusinessCard(
          order: order,
          onNext: () => indexNotifier.state++,
        );
      case 2:
        return ToClientCard(order: order, onNext: () => indexNotifier.state++);
      case 3:
        return AtClientCard(order: order, onFinish: resetOrderState);
      default:
        return const Center(child: Text("Statut de commande inconnu"));
    }
  }
}
