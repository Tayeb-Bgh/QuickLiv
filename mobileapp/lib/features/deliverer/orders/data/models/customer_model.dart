import 'package:mobileapp/features/deliverer/orders/business/entities/client_entity.dart';

class CustomerModel {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final double latitude;
  final double longitude;

  CustomerModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.latitude,
    required this.longitude,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
    id: json['idCust'],
    firstName: json['firstNameCust'],
    lastName: json['lastNameCust'],
    phone: json['phoneCust'],
    latitude: json['custLatOrd'],
    longitude: json['custLngOrd'],
  );
  Customer toEntity() {
    return Customer(
      id: id,
      name: '$firstName  $lastName',
      phone: phone,
      latClt: latitude,
      lngClt: longitude,
    );
  }
}
