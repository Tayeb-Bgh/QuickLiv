import 'package:mobileapp/features/customer/restaurant_opened/business/entities/restaurant_entity.dart';



class BusinessModel {
  final int idBusns;
  final String nameBusns;
  final String descBusns;
  final String imgUrlBusns;
  final String phoneBusns;
  final String instaUrlBusns;
  final String fcbUrlBusns;
  final double latBusns;
  final double lngBusns;

  BusinessModel({
    required this.idBusns,
    required this.nameBusns,
    required this.descBusns,
    required this.imgUrlBusns,
    required this.phoneBusns,
    required this.instaUrlBusns,
    required this.fcbUrlBusns,
    required this.latBusns,
    required this.lngBusns,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      idBusns: json["idBusns"],
      nameBusns: json["nameBusns"],
      descBusns: json["descBusns"],
      imgUrlBusns: json["imgUrlBusns"],
      phoneBusns: json["phoneBusns"],
      instaUrlBusns: json["instaUrlBusns"],
      fcbUrlBusns: json["fcbUrlBusns"],
      latBusns: json["latBusns"],
      lngBusns: json["lngBusns"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idBusns": idBusns,
      "nameBusns": nameBusns,
      "descBusns": descBusns,
      "imgUrlBusns": imgUrlBusns,
      "phoneBusns": phoneBusns,
      "instaUrlBusns": instaUrlBusns,
      "fcbUrlBusns": fcbUrlBusns,
      "latBusns": latBusns,
      "lngBusns": lngBusns,
    };
  }

  Restaurant toEntity(
    DateTime deliveryTime,
    double deliveryPrice,
    double rating,
    List<String> categories,
  ) {
    return Restaurant(
      id: idBusns,
      name: nameBusns,
      desc: descBusns,
      imgUrl: imgUrlBusns,
      phone: phoneBusns,
      instaUrl: instaUrlBusns,
      fcbUrl: fcbUrlBusns,
      deliveryPrice: deliveryPrice,
      deliveryTime: deliveryTime,
      rating: rating,
      categories: categories,
    );
  }
}
