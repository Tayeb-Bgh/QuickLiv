import 'package:mobileapp/features/customer/favourites/business/entities/business_entity.dart';

class BusinessModel {
  final int idBusns;
  final String nameBusns;
  final String descBusns;
  final String typeBusns;
  final double latBusns;
  final double lngBusns;

  BusinessModel({
    required this.idBusns,
    required this.nameBusns,
    required this.descBusns,
    required this.typeBusns,
    required this.latBusns,
    required this.lngBusns,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      idBusns: json["idBusns"],
      nameBusns: json["idBusns"],
      descBusns: json["idBusns"],
      typeBusns: json["typeBusns"],
      latBusns: json["latBusns"],
      lngBusns: json["lngBusns"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idBusns": idBusns,
      "nameBusns": nameBusns,
      "descBusns": idBusns,
      "typeBusns": typeBusns,
      "latBusns": latBusns,
      "lngBusns": lngBusns,
    };
  }

  Business toEntity(
    bool liked,
    double deliveryPrice,
    DateTime deliveryTime,
    double rating,
    bool open,
  ) {
    return Business(
      id: idBusns,
      name: nameBusns,
      desc: descBusns,
      type: typeBusns,
      liked: liked,
      deliveryTime: deliveryTime,
      deliveryPrice: deliveryPrice,
      rating: rating,
      open: open,
    );
  }
}
