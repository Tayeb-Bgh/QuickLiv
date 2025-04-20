// deliverer_hive_object.dart
import 'package:hive/hive.dart';
import 'package:mobileapp/features/auth/business/entities/deliverer_entity.dart';
import 'vehicle_hive_object.dart';

part 'deliverer_hive_object.g.dart';

@HiveType(typeId: 2)
class DelivererHiveObject extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String lastName;

  @HiveField(3)
  String phone;

  @HiveField(4)
  DateTime registerDate;

  @HiveField(5)
  double rating;

  @HiveField(6)
  int deliveryNbr;

  @HiveField(7)
  String email;

  @HiveField(8)
  String adrs;

  @HiveField(9)
  bool status;

  @HiveField(10)
  int? nbrOrderThisDay;

  @HiveField(11)
  double? profitsThisDay;

  @HiveField(12)
  VehicleHiveObject vehicle;

  DelivererHiveObject({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.registerDate,
    required this.rating,
    required this.deliveryNbr,
    required this.email,
    required this.adrs,
    required this.status,
    required this.nbrOrderThisDay,
    required this.profitsThisDay,
    required this.vehicle,
  });

  static DelivererHiveObject toHiveDeliverer(Deliverer d) {
  return DelivererHiveObject(
    id: d.id,
    firstName: d.firstName,
    lastName: d.lastName,
    phone: d.phone,
    registerDate: d.registerDate,
    rating: d.rating,
    deliveryNbr: d.deliveryNbr,
    email: d.email,
    adrs: d.adrs,
    status: d.status,
    nbrOrderThisDay: d.nbrOrderThisDay,
    profitsThisDay: d.profitsThisDay,
    vehicle: VehicleHiveObject(
      id: d.vehicle.id,
      registerNbr: d.vehicle.registerNbr,
      brand: d.vehicle.brand,
      model: d.vehicle.model,
      color: d.vehicle.color,
      year: d.vehicle.year,
      insuranceExpr: d.vehicle.insuranceExpr,
      type: d.vehicle.type.name, // ou `.toString().split('.').last`
    ),
  );
}
}
