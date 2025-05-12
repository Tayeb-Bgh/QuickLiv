class Customere {
  final String firstName;
  final String lastName;
  final String phone;
  final DateTime registerDate;
  final int points;
  final bool isSubmittedDeliverer;
  final bool isSubmittedPartner;
  final String birthDate;

  Customere({
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
    return 'Customere{ firstName: $firstName, lastName: $lastName, phone: $phone, registerDate: $registerDate, points: $points, birthDate: $birthDate, isSubmittedDeliverer: $isSubmittedDeliverer, isSubmittedPartner: $isSubmittedPartner}';
  }
  Map<String, dynamic> toJson() {
  return {
      'points': points,
    'firstName': firstName,
    'lastName': lastName,
    'birthDate': birthDate, 
    'registerDate': registerDate.toIso8601String(),
    'phone': phone,
    'isSubmittedDeliverer': isSubmittedDeliverer ? 1 : 0,
    'isSubmittedPartner': isSubmittedPartner ? 1 : 0,
  };
}

}
