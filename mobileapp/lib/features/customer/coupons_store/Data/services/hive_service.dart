// Fichier: features/customer/coupons_store/Data/services/hive_storage_service.dart

import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobileapp/core/hive_object/customer_hive_object.dart';
import 'package:mobileapp/core/hive_object/deliverer_hive_object.dart';
import 'package:mobileapp/core/hive_object/vehicle_hive_object.dart';
import 'package:mobileapp/features/customer/coupons_store/Data/models/hive_model.dart';
import 'package:mobileapp/features/customer/coupons_store/business/entities/coupon_entitie.dart';

class HiveStorageService {
  static const String pointsBoxName = 'customer_points';
  static const String couponsBoxName = 'customer_coupons';
  static const String pointsKey = 'current_points';

  // Initialiser Hive
  static Future<void> init() async {
    await Hive.initFlutter();

    // Enregistrer les adaptateurs
    Hive.registerAdapter(CustomerPointsHiveModelAdapter());
    Hive.registerAdapter(CouponHiveModelAdapter());
    Hive.registerAdapter(CustomerHiveObjectAdapter());
  Hive.registerAdapter(VehicleHiveObjectAdapter());
  Hive.registerAdapter(DelivererHiveObjectAdapter());

    // Ouvrir les boxes
    await Hive.openBox<CustomerPointsHiveModel>(pointsBoxName);
    await Hive.openBox<CouponHiveModel>(couponsBoxName);
  }

  // Méthodes pour les points
  static Future<void> savePoints(int points) async {
    final box = Hive.box<CustomerPointsHiveModel>(pointsBoxName);
    final model = CustomerPointsHiveModel(points: points);
    await box.put(pointsKey, model);
  }

  static int? getPoints() {
    final box = Hive.box<CustomerPointsHiveModel>(pointsBoxName);
    final model = box.get(pointsKey);
    return model?.points;
  }

  // Méthodes pour les coupons
  static Future<void> saveCoupons(List<CouponEntity> coupons) async {
    final box = Hive.box<CouponHiveModel>(couponsBoxName);
    await box.clear(); // Effacer les anciens coupons

    for (var coupon in coupons) {
      await box.add(
        CouponHiveModel(
          reductionCode: coupon.reductionCode ?? '',
          discountRate: coupon.discountRate,
        ),
      );
    }
  }

  static List<CouponEntity> getCoupons() {
    final box = Hive.box<CouponHiveModel>(couponsBoxName);

    return box.values
        .map(
          (model) => CouponEntity(
            reductionCode: model.reductionCode,
            discountRate: model.discountRate,
          ),
        )
        .toList();
  }
}
