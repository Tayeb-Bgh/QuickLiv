// vehicle_hive_object.dart
import 'package:hive/hive.dart';
import 'package:mobileapp/features/auth/business/entities/vehicle_entity.dart';

part 'vehicle_hive_object.g.dart';

@HiveType(typeId: 1)
class VehicleHiveObject extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String registerNbr;

  @HiveField(2)
  String brand;

  @HiveField(3)
  String model;

  @HiveField(4)
  String color;

  @HiveField(5)
  DateTime year;

  @HiveField(6)
  DateTime insuranceExpr;

  @HiveField(7)
  String type; // convert VehicleType to string

  VehicleHiveObject({
    required this.id,
    required this.registerNbr,
    required this.brand,
    required this.model,
    required this.color,
    required this.year,
    required this.insuranceExpr,
    required this.type,
  });

  static VehicleHiveObject toHiveVehicle(Vehicle vehicle) {
  return VehicleHiveObject(
    id: vehicle.id,
    registerNbr: vehicle.registerNbr,
    brand: vehicle.brand,
    model: vehicle.model,
    color: vehicle.color,
    year: vehicle.year,
    insuranceExpr: vehicle.insuranceExpr,
    type: vehicle.type.name, // Assure-toi que VehicleType est un enum
  );
}
}
