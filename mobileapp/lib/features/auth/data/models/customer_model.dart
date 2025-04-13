import 'package:mobileapp/features/auth/data/models/person_model.dart';

class CustomerModel extends PersonModel {
  final int pointsCust;

  CustomerModel({
    required int idPers,
    required String firstNamePers,
    required String lastNamePers,
    required DateTime bdayDatePers,
    required String phonePers,
    required this.pointsCust,
  }) : super(
         idPers: idPers,
         firstNamePers: firstNamePers,
         lastNamePers: lastNamePers,
         bdayDatePers: bdayDatePers,
         phonePers: phonePers,
       );

  @override
  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      idPers: json["idPers"],
      firstNamePers: json["firstNamePers"],
      lastNamePers: json["lastNamePers"],
      bdayDatePers: DateTime.parse(json["bdayDatePers"]),
      phonePers: json["phonePers"],
      pointsCust: json["pointsCust"],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    final data = super.toJson();
    data.addAll({"pointsCust": pointsCust});

    return data;
  }
}
