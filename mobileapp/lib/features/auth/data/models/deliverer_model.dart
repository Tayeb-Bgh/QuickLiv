import 'package:mobileapp/features/auth/business/entities/deliverer_entity.dart';
import 'package:mobileapp/features/auth/business/entities/vehicle_entity.dart';

class DelivererModel {
  final int idDel;
  final String firstNameDel;
  final String lastNameDel;
  final String phoneDel;
  final DateTime registerDateDel;
  final String emailDel;
  final String adrsDel;
  final bool statusDel;

  DelivererModel({required this.idDel, required this.firstNameDel, required this.lastNameDel, required this.phoneDel, required this.registerDateDel, required this.emailDel, required this.adrsDel, required this.statusDel});

  /// ✅ Factory pour construire un objet depuis un JSON
  factory DelivererModel.fromJson(Map<String, dynamic> json) {
    return DelivererModel(
      idDel: json['idDel'],
      firstNameDel: json['firstNameDel'],
      lastNameDel: json['lastNameDel'],
      phoneDel: json['phoneDel'],
      registerDateDel: DateTime.parse(json['registerDateDel']),
      emailDel: json['emailDel'],
      adrsDel: json['adrsDel'],
      statusDel: json['statusDel'] == 0 ? false : true,
    );
  }

  /// ✅ Méthode pour convertir l'objet en JSON
  Map<String, dynamic> toJson() {
    return {
      'idDel': idDel,
      'firstNameDel': firstNameDel,
      'lastNameDel': lastNameDel,
      'phoneDel': phoneDel,
      'registerDateDel': registerDateDel.toIso8601String(),
      'emailDel': emailDel,
      'adrsDel': adrsDel,
      'statusDel': statusDel,
    };
  }

  Deliverer toEntity({required double rating, required int deliveryNbr, required Vehicle vehicle}) {
    return Deliverer(
      id: idDel,
      firstName: firstNameDel,
      lastName: lastNameDel,
      phone: phoneDel,
      registerDate: registerDateDel,
      email: emailDel,
      adrs: adrsDel,
      status: statusDel,
      rating: rating, 
      deliveryNbr: deliveryNbr,
      nbrOrderThisDay: null,
      profitsThisDay: null,
      vehicle: vehicle,
      orderHistory: [],
      currentOrder: null,
      
    );
  }

 
  
}

