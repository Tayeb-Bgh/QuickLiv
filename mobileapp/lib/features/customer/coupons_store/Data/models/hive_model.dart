// Fichier: features/customer/coupons_store/Data/models/hive_models.dart

import 'package:hive/hive.dart';
part 'hive_model.g.dart';

@HiveType(typeId: 4)
class CustomerPointsHiveModel extends HiveObject {
  @HiveField(0)
  int points;

  CustomerPointsHiveModel({required this.points});
}

@HiveType(typeId: 5)
class CouponHiveModel extends HiveObject {
  @HiveField(0)
  String reductionCode;

  @HiveField(1)
  int discountRate;

  CouponHiveModel({required this.reductionCode, required this.discountRate});
}
