class Customer {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final DateTime registerDate;
  final int points;
  final bool isSubmittedDeliverer;
  final bool isSubmittedPartner;
  final DateTime birthDate;

  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.registerDate,
    required this.points,
    required this.birthDate,
    required this.isSubmittedDeliverer,
    required this.isSubmittedPartner,
  });

  @override
  String toString() {
    return 'Customer{id: $id, firstName: $firstName, lastName: $lastName, phone: $phone, registerDate: $registerDate, points: $points, birthDate: $birthDate, isSubmittedDeliverer: $isSubmittedDeliverer, isSubmittedPartner: $isSubmittedPartner}';
  }
}
