import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/features/deliverer/history/presentation/widgets/buttons_row.dart';
import 'package:mobileapp/features/deliverer/history/presentation/widgets/history_commad.dart';

class DeliveriesHistory extends StatefulWidget {
  const DeliveriesHistory({super.key});

  @override
  State<DeliveriesHistory> createState() => _DeliveriesHistoryState();
}

class _DeliveriesHistoryState extends State<DeliveriesHistory> {
  final int _selectedSegment = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 40,
        children: [
          HorizontalRadioButtons(),
          SizedBox(
            height: height * 0.67,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10),
              physics: BouncingScrollPhysics(),
              children: [
                HistoryCommand(
                  date: '2024-10-25',
                  heure: '14:30',
                  imgUrl: 'https://example.com/image.jpg',
                  items: [
                    OrderItem2(name: 'Item 2', quantity: 1, price: 20.0),
                    OrderItem2(name: 'Item 2', quantity: 1, price: 20.0),
                    OrderItem2(name: 'Item 2', quantity: 1, price: 20.0),
                  ],
                  locaComm: 'Paris',
                  location: 'test in blabla',
                  orderNumber: '123456',
                  status: 'Livrée',
                  paymentMethod: 'en ligne',
                  personName: 'BENKEROU Dussan',
                  price: '20.00',
                  restaurantName: 'Restaurant Name',
                  totalPrice: '15000.00',
                ),
                HistoryCommand(
                  date: '2024-10-25',
                  heure: '14:30',
                  imgUrl: 'https://example.com/image.jpg',
                  items: [
                    OrderItem2(name: 'Item 2', quantity: 1, price: 20.0),
                    OrderItem2(name: 'Item 2', quantity: 1, price: 20.0),
                    OrderItem2(name: 'Item 2', quantity: 1, price: 20.0),
                  ],
                  locaComm: 'Paris',
                  location: 'test in blabla',
                  orderNumber: '123456',
                  status: 'Livrée',
                  paymentMethod: 'en ligne',
                  personName: 'BENKEROU Dussan',
                  price: '20.00',
                  restaurantName: 'Restaurant Name',
                  totalPrice: '15000.00',
                ),
                HistoryCommand(
                  date: '2024-10-25',
                  heure: '14:30',
                  imgUrl: 'https://example.com/image.jpg',
                  items: [
                    OrderItem2(name: 'Item 2', quantity: 1, price: 20.0),
                    OrderItem2(name: 'Item 2', quantity: 1, price: 20.0),
                    OrderItem2(name: 'Item 2', quantity: 1, price: 20.0),
                  ],
                  locaComm: 'Paris',
                  location: 'test in blabla',
                  orderNumber: '123456',
                  status: 'Livrée',
                  paymentMethod: 'en ligne',
                  personName: 'BENKEROU Dussan',
                  price: '20.00',
                  restaurantName: 'Restaurant Name',
                  totalPrice: '15000.00',
                ),
                HistoryCommand(
                  date: '2024-10-25',
                  heure: '14:30',
                  imgUrl: 'https://example.com/image.jpg',
                  items: [
                    OrderItem2(name: 'Item 2', quantity: 1, price: 20.0),
                    OrderItem2(name: 'Item 2', quantity: 1, price: 20.0),
                    OrderItem2(name: 'Item 2', quantity: 1, price: 20.0),
                  ],
                  locaComm: 'Paris',
                  location: 'test in blabla',
                  orderNumber: '123456',
                  status: 'Livrée',
                  paymentMethod: 'en ligne',
                  personName: 'BENKEROU Dussan',
                  price: '20.00',
                  restaurantName: 'Restaurant Name',
                  totalPrice: '15000.00',
                ),
                HistoryCommand(
                  date: '2024-10-25',
                  heure: '14:30',
                  imgUrl: 'https://example.com/image.jpg',
                  items: [
                    OrderItem2(name: 'Item 2', quantity: 1, price: 20.0),
                    OrderItem2(name: 'Item 2', quantity: 1, price: 20.0),
                    OrderItem2(name: 'Item 2', quantity: 1, price: 20.0),
                  ],
                  locaComm: 'Paris',
                  location: 'test in blabla',
                  orderNumber: '123456',
                  status: 'Livrée',
                  paymentMethod: 'en ligne',
                  personName: 'BENKEROU Dussan',
                  price: '20.00',
                  restaurantName: 'Restaurant Name',
                  totalPrice: '15000.00',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// This now uses the _selectedSegment to highlight the correct one dynamically
}
