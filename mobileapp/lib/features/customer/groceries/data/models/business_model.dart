import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';

class BusinessModel {
  final int idBusns;
  final String nameBusns;
  final String descBusns;
  final String categoryBusns;
  final double latBusns;
  final double lngBusns;
  final String wilayaBusns;

  final String imgUrlBusns;
  final String vidUrlBusns;

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
    };
  }

  Grocery toEntity(
    bool liked,
    double deliveryPrice,
    int deliveryTime,
    double rating,
  ) {
    return Grocery(
      id: idBusns,
      name: nameBusns,
      description: descBusns,
      category: categoryBusns,
      imgUrl: imgUrlBusns,
      vidUrl: vidUrlBusns,
      liked: liked,
      delivTime: deliveryTime,
      delivPrice: deliveryPrice,
      rating: rating,
    );
  }
}
