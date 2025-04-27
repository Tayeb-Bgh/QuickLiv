import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/customer/orders_history/presentation/widgets/current_Order.dart';
import 'package:mobileapp/features/customer/orders_history/presentation/widgets/previous_Order.dart';

class MyOrdersPage extends ConsumerStatefulWidget {
  const MyOrdersPage({super.key});

  @override
  ConsumerState<MyOrdersPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends ConsumerState<MyOrdersPage> {
  bool _isEnCours = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Mes commandes',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Filtres "En Cours" et "Anciennes"
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isEnCours = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isEnCours ? Colors.white : Colors.red,
                      foregroundColor: _isEnCours ? Colors.red : Colors.white,
                      shape: const StadiumBorder(),
                      side: BorderSide(color: Colors.red),
                    ),
                    child: const Text('En Cours'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isEnCours = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !_isEnCours ? Colors.white : Colors.red,
                      foregroundColor: !_isEnCours ? Colors.red : Colors.white,
                      shape: const StadiumBorder(),
                      side: BorderSide(color: Colors.red),
                    ),
                    child: const Text('Anciennes'),
                  ),
                ),
              ],
            ),
          ),

        // Liste des commandes
Expanded(
  child: _isEnCours ? const CurrentOrder() : const PreviousOrder(),
),
        ],
      ),
    );
  }
}
