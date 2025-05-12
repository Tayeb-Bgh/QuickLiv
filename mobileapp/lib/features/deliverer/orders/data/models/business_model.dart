import 'package:mobileapp/features/deliverer/orders/business/entities/business_entity.dart';

class BusinessModel {
  final int id;
  final String name;
  final String phone;
  final double latitude;
  final double longitude;
  final String imageUrl;
  final String address;
  BusinessModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.latitude,
    required this.longitude,
    required this.imageUrl,
    required this.address
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) => BusinessModel(
    id: json['idBusns'],
    name: json['nameBusns'],
    phone: json['phoneBusns'],
    latitude: json['latBusns'],
    longitude: json['lngBusns'],
    imageUrl: json['imgUrlBusns'],
    address: json['adrsBusns']
  );
  Business toEntity() {
    return Business(
      id: id,
      name: name,
      phone: phone,
      latBusns: latitude,
      lngBusns: longitude,
      imgUrl: imageUrl,
      time: DateTime.now(),
      address  :address
    );
  }
}
