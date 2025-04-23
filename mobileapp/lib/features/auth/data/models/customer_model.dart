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

  CustomerModel({
    required this.idCust,
    required this.firstNameCust,
    required this.lastNameCust,
    required this.phoneCust,
    required this.registerDateCust,
    required this.pointsCust,
    required this.isSubmittedDelivererCust,
    required this.isSubmittedPartnerCust,
  });

  /// ✅ Factory pour construire un objet depuis un JSON
  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      idCust: json['idCust'],
      firstNameCust: json['firstNameCust'],
      lastNameCust: json['lastNameCust'],
      phoneCust: json['phoneCust'],
      registerDateCust: DateTime.parse(json['registerDateCust']),
      pointsCust: json['pointsCust'],
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
      'firstNameCust': firstNameCust,
      'lastNameCust': lastNameCust,
      'phoneCust': phoneCust,
      'registerDateCust': registerDateCust.toIso8601String(),
      'pointsCust': pointsCust,
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
      phone: phoneCust,
      registerDate: registerDateCust,
      isSubmittedDeliverer: isSubmittedDelivererCust,
      isSubmittedPartner: isSubmittedPartnerCust,
      carts: List.empty(),
      favorites: List.empty(),
      ordersHistory: List.empty(),
      coupons: List.empty(),
    );
  }
}
