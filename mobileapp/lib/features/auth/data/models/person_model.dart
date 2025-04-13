class PersonModel {
  final int idPers;
  final String firstNamePers;
  final String lastNamePers;
  final DateTime bdayDatePers;
  final String phonePers;

  PersonModel({
    required this.idPers,
    required this.firstNamePers,
    required this.lastNamePers,
    required this.bdayDatePers,
    required this.phonePers,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      idPers: json["idPers"],
      firstNamePers: json["firstNamePers"],
      lastNamePers: json["lastNamePers"],
      bdayDatePers: json["bdayDatePers"],
      phonePers: json["phonePers"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idPers": idPers,
      "firstNamePers": firstNamePers,
      "lastNamePers": lastNamePers,
      "bdayDatePers": bdayDatePers,
      "phonePers": phonePers,
    };
  }
}
