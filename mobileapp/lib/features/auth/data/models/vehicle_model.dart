import 'package:mobileapp/features/auth/business/entities/vehicle_entity.dart';

enum VehicleType {
  scooter,
  car,
}

class VehicleModel {
  final int idVehc;
  final String registerNbrVehc;
  final String brandVehc;
  final String modelVehc;
  final String colorVehc;
  final DateTime yearVehc;
  final DateTime insuranceExprVehc;
  final VehicleType typeVehc;

  VehicleModel({required this.idVehc, required this.registerNbrVehc, required this.brandVehc, required this.modelVehc, required this.colorVehc, required this.yearVehc, required this.insuranceExprVehc, required this.typeVehc});
  
  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      idVehc: json['idVehc'],
      registerNbrVehc: json['registerNbrVehc'],
      brandVehc: json['brandVehc'],
      modelVehc: json['modelVehc'],
      colorVehc: json['colorVehc'],
      yearVehc: DateTime.parse(json['yearVehc']),
      insuranceExprVehc: DateTime.parse(json['insuranceExprVehc']),
      typeVehc: _vehicleTypeFromString(json['typeVehc']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idVehc': idVehc,
      'registerNbrVehc': registerNbrVehc,
      'brandVehc': brandVehc,
      'modelVehc': modelVehc,
      'colorVehc': colorVehc,
      'yearVehc': yearVehc.toIso8601String(),
      'insuranceExprVehc': insuranceExprVehc.toIso8601String(),
      'typeVehc': typeVehc.name, // .name donne 'scooter' ou 'car'
    };
  }

  Vehicle toEntity() {
    return Vehicle(
      id: idVehc,
      registerNbr: registerNbrVehc,
      brand: brandVehc,
      model: modelVehc,
      color: colorVehc,
      year: yearVehc,
      insuranceExpr: insuranceExprVehc,
      type: typeVehc,
    );
  }

  static VehicleType _vehicleTypeFromString(String type) {
    switch (type.toLowerCase()) {
      case 'car':
        return VehicleType.car;
      case 'scooter':
        return VehicleType.scooter;
      default:
        throw Exception('Unknown vehicle type: $type');
    }
  }
}


