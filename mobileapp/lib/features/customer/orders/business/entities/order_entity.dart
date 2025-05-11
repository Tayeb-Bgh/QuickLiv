import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapp/features/customer/orders/business/entities/business_entity.dart';
import 'package:mobileapp/features/customer/orders/business/entities/deliverer_entity.dart';
import 'package:mobileapp/features/customer/orders/business/entities/product_entity.dart';

class Order {
  final int id;
  int status;
  final DateTime createdAt;
  final double totalAmount;
  final double? priceWithReduc;
  final double deliveryPrice;
  final bool paymentMethod;
  final Business business;
  Deliverer? deliverer;
  final List<Product> products;
  int? ratingBusns;
  int? ratingDel;
  LatLng? delivererLocation;
  final LatLng customerLocation;
  int? pointWon;

  Order({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.totalAmount,
    required this.priceWithReduc,
    required this.deliveryPrice,
    required this.paymentMethod,
    required this.business,
    this.deliverer,
    required this.products,
    this.ratingBusns,
    this.ratingDel,
    required this.delivererLocation,
    required this.customerLocation,
    this.pointWon,
  });

  Order copyWithStatus(int newStatus) {
    return Order(
      id: id,
      status: newStatus, // Seul champ modifié
      createdAt: createdAt,
      totalAmount: totalAmount,
      priceWithReduc: priceWithReduc,
      deliveryPrice: deliveryPrice,
      paymentMethod: paymentMethod,
      business: business,
      deliverer: deliverer,
      products: products,
      ratingBusns: ratingBusns,
      ratingDel: ratingDel,
      delivererLocation: delivererLocation,
      customerLocation: customerLocation,
      pointWon: pointWon,
    );
  }

  @override
  String toString() {
    return 'Order{id: $id, status: $status, createdAt: $createdAt, totalAmount: $totalAmount, priceWithReduc: $priceWithReduc, business: $business, deliverer: $deliverer, products: $products, ratingBusns: $ratingBusns, ratingDel: $ratingDel}';
  }
}
