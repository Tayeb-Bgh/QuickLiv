class ValidateInputs {
 bool validatePhoneNumber(String telephone) {
    return RegExp(r'^[5|6|7][0-9]{8}$').hasMatch(telephone);
  }
  bool validateDateNais(String dateNais) {
  return RegExp(
    r'^(19|20)\d\d-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$',
  ).hasMatch(dateNais);
}
  String transformNameToUppercase(String name) {
    return name.toUpperCase();
  }

}