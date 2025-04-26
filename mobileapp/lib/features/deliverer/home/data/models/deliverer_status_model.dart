import 'package:mobileapp/features/deliverer/home/business/entities/deliverer_status_entity.dart';

class DelivererStatusModel {
  final int numberOfOrders;
  final double profit;
  final bool isOnline;

  DelivererStatusModel({
    required this.numberOfOrders,
    required this.profit,
    required this.isOnline,
  });
  factory DelivererStatusModel.fromJson(Map<String, dynamic> json) {
    final isOnline = json['status'] == 1 ? true : false;
    print('the is online is $isOnline');
    print('the json is $json');
    return DelivererStatusModel(
      numberOfOrders: json['orders'] ?? 0,
      profit: (json['profit'] ?? 0).toDouble(),
      isOnline:   isOnline,
    );
  }
  Map<String, dynamic> toJson() {
    return {'orders': numberOfOrders, 'profit': profit, 'isOnline': isOnline};
  }

  DelivererStatusEntity toEntity() {
    return DelivererStatusEntity(
      numberOfOrders: numberOfOrders,
      profit: profit,
      isOnline: isOnline,
    );
  }
}
