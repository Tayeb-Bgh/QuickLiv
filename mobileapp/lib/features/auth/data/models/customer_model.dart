import 'package:mobileapp/features/auth/business/entities/customer_entity.dart';

class CustomerModel {
  final int idCust;
  final String firstNameCust;
  final String lastNameCust;
  final String phoneCust;
  final DateTime registerDateCust;
  final int pointsCust;
  final bool isSubmittedDelivererCust;
  final bool isSubmittedPartnerCust;
  final birthDateCust;

  CustomerModel({
    required this.idCust,
    required this.pointsCust,
    required this.firstNameCust,
    required this.lastNameCust,
    required this.birthDateCust,
    required this.phoneCust,
    required this.registerDateCust,
    required this.isSubmittedDelivererCust,
    required this.isSubmittedPartnerCust,
  });

  /// ✅ Factory pour construire un objet depuis un JSON
  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      idCust: json['idCust'],
      pointsCust: json['pointsCust'],
      firstNameCust: json['firstNameCust'],
      lastNameCust: json['lastNameCust'],
      birthDateCust: json['birthDateCust'],
      phoneCust: json['phoneCust'],
      registerDateCust: DateTime.parse(json['registerDateCust']),
      isSubmittedDelivererCust:
          json['isSubmittedDelivererCust'] == 0 ? false : true,
      isSubmittedPartnerCust:
          json['isSubmittedPartnerCust'] == 0 ? false : true,
    );
  }

  /// ✅ Méthode pour convertir l'objet en JSON
  Map<String, dynamic> toJson() {
    return {
      'idCust': idCust,
      'pointsCust': pointsCust,
      'firstNameCust': firstNameCust,
      'lastNameCust': lastNameCust,
      'phoneCust': phoneCust,
      'registerDateCust': registerDateCust.toIso8601String(),

      'isSubmittedDelivererCust': isSubmittedDelivererCust,
      'isSubmittedPartnerCust': isSubmittedPartnerCust,
    };
  }

  Customer toEntity() {
    return Customer(
      id: idCust,
      points: pointsCust,
      firstName: firstNameCust,
      lastName: lastNameCust,
      birthDate: birthDateCust,
      phone: phoneCust,
      registerDate: registerDateCust,
      isSubmittedDeliverer: isSubmittedDelivererCust,
      isSubmittedPartner: isSubmittedPartnerCust,
    );
  }
}
