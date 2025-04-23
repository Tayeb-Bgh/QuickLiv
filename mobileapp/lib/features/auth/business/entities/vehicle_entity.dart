import 'package:mobileapp/features/auth/data/models/vehicle_model.dart';

class Vehicle {
  final int id;
  final String registerNbr;
  final String brand;
  final String model;
  final String color;
  final DateTime year;
  final DateTime insuranceExpr;
  final VehicleType type;

  Vehicle({
    required this.id,
    required this.registerNbr,
    required this.brand,
    required this.model,
    required this.color,
    required this.year,
    required this.insuranceExpr,
    required this.type,
  });

   @override
  String toString() {
    return 'Vehicle{id: $id, registerNbr: $registerNbr, brand: $brand, model: $model, color: $color, year: $year, insuranceExpr: $insuranceExpr, type: $type}';
  }
}
