import 'package:flutter/material.dart';
import 'package:mobileapp/features/customer/favourites/business/entities/business_entity.dart';

class BusinessModel {
  final int idBusns;
  final String nameBusns;
  final String typeBusns;
  final String descBusns;
  final double latBusns;
  final double lngBusns;
  final String wilayaBusns;
  final String? imgUrlBusns;
  final String hourOpenBusns;
  final String hourCloseBusns;
  final int dayOffBusns;

  BusinessModel({
    required this.idBusns,
    required this.nameBusns,
    required this.descBusns,
    required this.typeBusns,
    required this.latBusns,
    required this.lngBusns,
    required this.wilayaBusns,
    required this.imgUrlBusns,
    required this.hourOpenBusns,
    required this.hourCloseBusns,
    required this.dayOffBusns,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      idBusns: json['idBusns'] as int,
      nameBusns: json['nameBusns'] as String,
      typeBusns: json['typeBusns'] as String,
      descBusns: json['descBusns'] as String,
      latBusns:
          json['latBusns'] is int
              ? (json['latBusns'] as int).toDouble()
              : json['latBusns'] as double,
      lngBusns:
          json['lngBusns'] is int
              ? (json['lngBusns'] as int).toDouble()
              : json['lngBusns'] as double,
      wilayaBusns: json['wilayaBusns'] as String,
      imgUrlBusns: json['imgUrlBusns'] as String?,
      hourOpenBusns: json['hourOpenBusns'] as String,
      hourCloseBusns: json['hourCloseBusns'] as String,
      dayOffBusns: json['dayOffBusns'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idBusns": idBusns,
      "nameBusns": nameBusns,
      "descBusns": descBusns,
      "typeBusns": typeBusns,
      "latBusns": latBusns,
      "lngBusns": lngBusns,
      "imgUrlBusns": imgUrlBusns,
      "wilayaBusns": wilayaBusns,
      "hourOpenBusns": hourOpenBusns,
      "hourCloseBusns": hourCloseBusns,
      "dayOffBusns": dayOffBusns,
    };
  }

  Business toEntity(
    bool liked,
    double deliveryPrice,
    int deliveryTime,
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
      open: isOpen(),
      imgUrlBusns: imgUrlBusns,
    );
  }

  bool isOpen() {
    final now = DateTime.now();
    final currentTime = TimeOfDay.fromDateTime(now);

    if (now.weekday == dayOffBusns) {
      return false;
    }

    final openTime = _timeFromString(hourOpenBusns);
    final closeTime = _timeFromString(hourCloseBusns);

    return currentTime.isAfter(openTime) && currentTime.isBefore(closeTime);
  }

  TimeOfDay _timeFromString(String time) {
    final parts = time.split(":");
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  String getClosedDayName() {
    const days = {
      1: 'Samedi',
      2: 'Dimanche',
      3: 'Lundi',
      4: 'Mardi',
      5: 'Mercredi',
      6: 'Jeudi',
      7: 'Vendredi',
    };
    return days[dayOffBusns] ?? 'Inconnu';
  }
}
