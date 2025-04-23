import 'package:hive/hive.dart';
import 'package:mobileapp/features/auth/business/entities/customer_entity.dart';

part 'customer_hive_object.g.dart';

@HiveType(typeId: 0)
class CustomerHiveObject extends HiveObject {
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
  int points;

  @HiveField(6)
  bool isSubmittedDeliverer;

  @HiveField(7)
  bool isSubmittedPartner;

  
  CustomerHiveObject({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.registerDate,
    required this.points,
    required this.isSubmittedDeliverer,
    required this.isSubmittedPartner,
  });

  static CustomerHiveObject toHiveCustomer(Customer customer) {
  return CustomerHiveObject(
    id: customer.id,
    firstName: customer.firstName,
    lastName: customer.lastName,
    phone: customer.phone,
    registerDate: customer.registerDate,
    points: customer.points,
    isSubmittedDeliverer: customer.isSubmittedDeliverer,
    isSubmittedPartner: customer.isSubmittedPartner,
  );
  
}
}
