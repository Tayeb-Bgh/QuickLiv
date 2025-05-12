import 'package:mobileapp/features/deliverer/orders/business/entities/business_entity.dart';
import 'package:mobileapp/features/deliverer/orders/business/entities/client_entity.dart';
import 'package:mobileapp/features/deliverer/orders/business/entities/product_entity.dart';

class OrderEntity {
  final int id;
  final int status;
  List<Product> products;
  final Business busns;
  final double delPrice;
  final String type;
  final DateTime time;
  final Customer customer;
  final bool payMethod;
  double totalPrice;

  OrderEntity({
    required this.id,
    required this.status,
    required this.products,
    required this.busns,
    required this.delPrice,
    required this.type,
    required this.time,
    required this.customer,
    required this.payMethod,
    required this.totalPrice,
  });
}
