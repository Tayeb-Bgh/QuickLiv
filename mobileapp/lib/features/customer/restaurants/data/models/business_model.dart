import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';

class BusinessModel {
  final int idBusns;
  final String? nameBusns;
  final String? descBusns;
  final String categoryBusns;
  final double latBusns;
  final double lngBusns;
  final String? wilayaBusns;

  final String? imgUrlBusns;
  final String? vidUrlBusns;

  final String? instaUrlBusns;
  final String? fcbUrlBusns;
  final String? phoneBusns;

  BusinessModel({
    required this.idBusns,
    required this.nameBusns,
    required this.descBusns,
    required this.categoryBusns,
    required this.latBusns,
    required this.lngBusns,
    required this.wilayaBusns,
    required this.imgUrlBusns,
    required this.vidUrlBusns,
    this.instaUrlBusns,
    this.fcbUrlBusns,
    this.phoneBusns,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      idBusns: json["idBusns"],
      nameBusns: json["nameBusns"],
      descBusns: json["descBusns"],
      categoryBusns: json["categoryBusns"],
      latBusns: json["latBusns"],
      lngBusns: json["lngBusns"],
      wilayaBusns: json["wilayaBusns"],
      imgUrlBusns: json["imgUrlBusns"],
      vidUrlBusns: json["vidUrlBusns"],
      instaUrlBusns: json["instaUrlBusns"],
      fcbUrlBusns: json["fcbUrlBusns"],
      phoneBusns: json["fcbUrlBusns"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idBusns": idBusns,
      "nameBusns": nameBusns,
      "descBusns": idBusns,
      "categoryBusns": categoryBusns,
      "latBusns": latBusns,
      "lngBusns": lngBusns,
      "imgUrlBusns": imgUrlBusns,
      "vidUrlBusns": vidUrlBusns,
      "wilayaBusns": wilayaBusns,
      "instaUrlBusns": "instaUrlBusns",
      "fcbUrlBusns": "fcbUrlBusns",
      "phoneBusns": "fcbUrlBusns",
    };
  }

  Restaurant toEntity(
    bool liked,
    double deliveryPrice,
    int deliveryTime,
    double rating,
    double distance,
  ) {
    return Restaurant(
      id: idBusns,
      name: nameBusns ?? "",
      description: descBusns ?? "",
      category: categoryBusns,
      imgUrl: imgUrlBusns ?? "",
      vidUrl: vidUrlBusns ?? "",
      liked: liked,
      delivTime: deliveryTime,
      delivPrice: deliveryPrice,
      rating: rating,
      distance: distance,
      insta: imgUrlBusns,
      fcb: fcbUrlBusns,
      phone: phoneBusns,
    );
  }
}
