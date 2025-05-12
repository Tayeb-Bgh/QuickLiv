import 'package:mobileapp/features/deliverer/orders/business/entities/order_entity.dart';
import 'package:mobileapp/features/deliverer/orders/data/models/business_model.dart';
import 'package:mobileapp/features/deliverer/orders/data/models/customer_model.dart';

class OrderModel {
  final int id;
  final String createdAt;
  final String weightCategory;
  final double deliveryPrice;
  final bool transactionNumber;
  final CustomerModel customer;
  final BusinessModel business;
  final int status;

  OrderModel({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.weightCategory,
    required this.deliveryPrice,
    required this.transactionNumber,
    required this.customer,
    required this.business,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json['idOrd'] ?? 0,
    createdAt: json['createdAtOrd'] ?? '',
    weightCategory: json['weightCatOrd'] ?? '',
    deliveryPrice: (json['delivPriceOrd'] ?? 0).toDouble(),
    transactionNumber: (json['transNbrOrd'] ?? 0) == 1,
    status: json['statusOrd'],
    customer: CustomerModel(
      id: json['idCust'] ?? 0,
      firstName: json['firstNameCust'] ?? '',
      lastName: json['lastNameCust'] ?? '',
      phone: json['phoneCust'] ?? '',
      latitude: json['custLatOrd'],
      longitude: json['custLatOrd'],
    ),
    business: BusinessModel(
      id: json['idBusns'] ?? 0,
      name: json['nameBusns'] ?? '',
      phone: json['phoneBusns'] ?? '',
      latitude: (json['latBusns'] as num?)?.toDouble() ?? 0,
      longitude: (json['lngBusns'] as num?)?.toDouble() ?? 0,
      imageUrl: json['imgUrlBusns'] ?? '',
      address: json['adrsBusns'],
    ),
  );

  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      time: DateTime.parse(createdAt),
      type: weightCategory,
      delPrice: deliveryPrice,
      payMethod: transactionNumber,
      customer: customer.toEntity(),
      busns: business.toEntity(),
      status: status,
      totalPrice: 0,
      products: [],
    );
  }
}
