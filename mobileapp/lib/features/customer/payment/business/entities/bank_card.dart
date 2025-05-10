class BankCard {
  final String cardNb;
  final String cvvNb;
  final String dateExp;
  final String nameOwner;
  double sold;

  static final RegExp _cardRegex = RegExp(r'^6280\d{12}$');
  static final RegExp _dateRegex = RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$');
  static final RegExp _cvvRegex = RegExp(r'^\d{3,4}$');

  BankCard({
    required this.cardNb,
    required this.cvvNb,
    required this.dateExp,
    required this.nameOwner,
    required this.sold,
  });

  void retrieveSold(double amount) {
    sold -= amount;
  }

  static bool isValidAlgerianCardFormat(String cardNumber) {
    return _cardRegex.hasMatch(cardNumber);
  }

  static bool isValidDateFormat(String date) {
    return _dateRegex.hasMatch(date);
  }

  static bool isValidCvvFormat(String cvv) {
    return _cvvRegex.hasMatch(cvv);
  }
}
