import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/deliverer/history/presentation/providers/deliverer_history_provider.dart';

class CompleteOrderWidget extends ConsumerStatefulWidget {
  const CompleteOrderWidget({super.key});

  @override
  ConsumerState<CompleteOrderWidget> createState() =>
      _CompleteOrderWidgetState();
}

class _CompleteOrderWidgetState extends ConsumerState<CompleteOrderWidget> {
  @override
  void initState() {
    super.initState();
    // Appel de la méthode fetch lors de l'initialisation
    Future.microtask(() {
      ref.read(completeOrdersProvider.notifier).fetchCompleteOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final completeOrdersState = ref.watch(completeOrdersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Commandes Complètes')),
      body:
          completeOrdersState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : completeOrdersState.errorMessage != null
              ? Center(
                child: Text(
                  completeOrdersState.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              )
              : completeOrdersState.completeOrders.isEmpty
              ? const Center(child: Text('Aucune commande trouvée'))
              : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: completeOrdersState.completeOrders.length,
                itemBuilder: (context, index) {
                  final completeOrder =
                      completeOrdersState.completeOrders[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Commande # ${completeOrder.order.idOrd}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Client : ${completeOrder.customer.firstName} ${completeOrder.customer.lastName}',
                          ),
                          const SizedBox(height: 8),
                          Text('Commerce : ${completeOrder.business.name}'),
                          const SizedBox(height: 8),
                          Text('Adresse : ${completeOrder.business.address}'),
                          Text(
                            'Statut livraison: ${completeOrder.order.cancelComment == "" ? "Livrée" : "Annulée"}',
                          ),
                          Text(
                            'Moyen de paiement: ${completeOrder.order.transactionNumber == 0 ? "en espèces" : "par carte"}',
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Date : ${completeOrder.order.createdAt.day}-${completeOrder.order.createdAt.month}-${completeOrder.order.createdAt.year}',
                          ),
                          Text(
                            'Heure : ${completeOrder.order.createdAt.hour}:${completeOrder.order.createdAt.minute.toString().padLeft(2, '0')}',
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Montant total : ${completeOrder.totalAmount.toStringAsFixed(2)} €',
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Montant total : ${completeOrder.order.deliveryPrice}',
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Produits :',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...completeOrder.products.map(
                            (product) => Text(
                              '- ${product.name} (Quantité : ${product.quantity})',
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
