import 'package:mobileapp/features/auth/data/models/person_model.dart';

class DelivererModel extends PersonModel {
  final String emailDel;
  final String sexDel;
  final String adrsDel;
  final String socSecNbrDel;
  final String driveLicDel;
  final bool statusDel;
  final bool authorizedDel;

  final int vehicleDel;

  DelivererModel({
    required int idPers,
    required String firstNamePers,
    required String lastNamePers,
    required DateTime bdayDatePers,
    required String phonePers,
    required this.emailDel,
    required this.sexDel,
    required this.adrsDel,
    required this.socSecNbrDel,
    required this.driveLicDel,
    required this.statusDel,
    required this.authorizedDel,
    required this.vehicleDel,
  }) : super(
         idPers: idPers,
         firstNamePers: firstNamePers,
         lastNamePers: lastNamePers,
         bdayDatePers: bdayDatePers,
         phonePers: phonePers,
       );

  factory DelivererModel.fromJson(Map<String, dynamic> json) {
    return DelivererModel(
      idPers: json["idPers"],
      firstNamePers: json["firstNamePers"],
      lastNamePers: json["lastNamePers"],
      bdayDatePers: DateTime.parse(json["bdayDatePers"]),
      phonePers: json["phonePers"],
      emailDel: json["emailDel"],
      sexDel: json["sexDel"],
      adrsDel: json["adrsDel"],
      socSecNbrDel: json["socSecNbrDel"],
      driveLicDel: json["driveLicDel"],
      statusDel: json["statusDel"],
      authorizedDel: json["authorizedDel"],
      vehicleDel: json["vehicleDel"],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data.addAll({
      "emailDel": emailDel,
      "sexDel": sexDel,
      "adrsDel": adrsDel,
      "socSecNbrDel": socSecNbrDel,
      "driveLicDel": driveLicDel,
      "statusDel": statusDel,
      "autorizedDel": authorizedDel,
      "vehicleDel": vehicleDel,
    });
    return data;
  }
}
