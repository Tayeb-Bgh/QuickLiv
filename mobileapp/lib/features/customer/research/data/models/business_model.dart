import 'package:mobileapp/features/customer/research/business/entities/business_entity.dart';
import 'package:mobileapp/features/customer/research/business/entities/product_entity.dart';
import 'package:intl/intl.dart';

class BusinessModel {
  final int idBusns;
  final String nameBusns;
  final String typeBusns;
  final String categoryBusns;
  final String descBusns;
  final String imgUrlBusns;
  final String? vidUrlBusns;
  final double lngBusns;
  final double latBusns;
  final DateTime hourOpenBusns;
  final DateTime hourCloseBusns;
  final int dayOffBusns;

  final String? instaUrlBusns;
  final String? fcbUrlBusns;
  final String? phoneBusns;

  BusinessModel({
    required this.idBusns,
    required this.nameBusns,
    required this.typeBusns,
    required this.categoryBusns,
    required this.imgUrlBusns,
    required this.descBusns,
    this.vidUrlBusns,
    required this.lngBusns,
    required this.latBusns,
    required this.hourOpenBusns,
    required this.hourCloseBusns,
    required this.dayOffBusns,
    this.instaUrlBusns,
    this.fcbUrlBusns,
    this.phoneBusns,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      idBusns: json["idBusns"],
      descBusns: json["descBusns"],
      nameBusns: json["nameBusns"],
      typeBusns: json["typeBusns"],
      categoryBusns: json["categoryBusns"],
      imgUrlBusns: json["imgUrlBusns"],
      vidUrlBusns: json["vidUrlBusns"],
      lngBusns: json["lngBusns"],
      latBusns: json["latBusns"],
      hourOpenBusns: DateFormat("HH:mm").parse(json["hourOpenBusns"]),
      hourCloseBusns: DateFormat("HH:mm").parse(json["hourCloseBusns"]),
      dayOffBusns: json["dayOffBusns"],
      instaUrlBusns: json["instaUrlBusns"],
      fcbUrlBusns: json["fcbUrlBusns"],
      phoneBusns: json["fcbUrlBusns"],
    );
  }

  Business toEntity(
    double delivPrice,
    int delivDuration,
    double rating,
    List<Product> products,
    double distance,
  ) {
    return Business(
      id: idBusns,
      distance: distance,
      name: nameBusns,
      imgUrl: imgUrlBusns,
      description: descBusns,
      vidUrl: vidUrlBusns ?? "",
      type: typeBusns,
      delivPrice: delivPrice,
      delivDuration: delivDuration,
      rating: rating,
      open: Business.isOpen(dayOffBusns, hourOpenBusns, hourCloseBusns),
      products: products,
      insta: imgUrlBusns,
      fcb: fcbUrlBusns,
      phone: phoneBusns,
    );
  }
}
