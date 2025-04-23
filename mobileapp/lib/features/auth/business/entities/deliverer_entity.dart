// Entity qui est senser servir a fetch toute les info du livreur actuellement connecter
import 'package:mobileapp/features/auth/business/entities/vehicle_entity.dart';
import 'package:mobileapp/features/customer/orders_history/business/entities/order_history_entity.dart';

class Order {}

class Deliverer {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final DateTime registerDate;
  final double rating;
  final int deliveryNbr;
  final String email;
  final String adrs;
  final bool status;
  final int? nbrOrderThisDay;
  final double? profitsThisDay;

  final Vehicle vehicle;
  final List<OrderHistory?> orderHistory;
  final Order? currentOrder;

  Deliverer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.registerDate,
    required this.rating,
    required this.deliveryNbr,
    required this.email,
    required this.adrs,
    required this.nbrOrderThisDay,
    required this.profitsThisDay,
    required this.vehicle,
    required this.status,
    required this.orderHistory,
    required this.currentOrder,
  });

  @override
  String toString() {
    return 'Deliverer{id: $id, firstName: $firstName, lastName: $lastName, phone: $phone, registerDate: $registerDate, rating: $rating, deliveryNbr: $deliveryNbr, email: $email, adrs: $adrs, status: $status, nbrOrderThisDay: $nbrOrderThisDay, profitsThisDay: $profitsThisDay, vehicle: ${vehicle.toString()}, orderHistory: $orderHistory, currentOrder: $currentOrder}';
  }
}
