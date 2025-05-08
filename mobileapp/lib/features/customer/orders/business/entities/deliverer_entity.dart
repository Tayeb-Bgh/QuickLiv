class Deliverer {
  final int id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? imgUrl;

  Deliverer({required this.id, required this.firstName, required this.lastName, required this.phoneNumber, required this.imgUrl});

  
  @override
  String toString() {
    return 'Deliverer{id: $id, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, imgUrl: $imgUrl}';
  }
}