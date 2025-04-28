import 'package:mobileapp/features/customer/coupons_store/business/entities/Customer_entitie.dart';

class CustomerPointsModel {
  final int points;

  CustomerPointsModel({required this.points});

  factory CustomerPointsModel.fromEntity(
    CustomerPointsEntity customerPointEntity,
  ) {
    return CustomerPointsModel(points: customerPointEntity.customerPoints);
  }

  CustomerPointsEntity toEntity() {
    return CustomerPointsEntity(customerPoints: points);
  }

  factory CustomerPointsModel.fromJson(Map<String, dynamic> json) {
    return CustomerPointsModel(points: json['pointsCust'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {'pointsCust': points};
  }
}
