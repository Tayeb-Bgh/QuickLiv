class Validatetrader {
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
    return RegExp(r'^0[0-9]{9}$').hasMatch(telephone);
  }

  bool validateDocuments({
    required String? pieceIdentit,
    required String? regCommerce,
    required String? paieImpots,
    required String? autoSanitaire,
  }) {
    return pieceIdentit != null &&
        regCommerce != null &&
        paieImpots != null &&
        autoSanitaire != null;
  }
}
