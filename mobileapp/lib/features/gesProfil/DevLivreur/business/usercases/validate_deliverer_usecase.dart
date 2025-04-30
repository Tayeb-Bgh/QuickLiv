class Validatedeliverer {
  String transformNameToUppercase(String name) {
    return name.toUpperCase();
  }

bool validateDateNais(String dateNais) {
  return RegExp(
    r'^(19|20)\d\d-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$',
  ).hasMatch(dateNais);
}


  bool validateEmail(String email) {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    ).hasMatch(email);
  }

  bool validatePhoneNumber(String telephone) {
    return RegExp(r'^0[5|6|7][0-9]{8}$').hasMatch(telephone);
  }

  bool validateDocuments({
    required String? photoIdentite,
    required String? photoVehicule,
    required String? permisConduire,
    required String? carteGrise,
  }) {
    return photoIdentite != null &&
        photoVehicule != null &&
        permisConduire != null &&
        carteGrise != null;
  }
}
