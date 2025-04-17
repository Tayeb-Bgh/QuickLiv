// Entity qui est senser servir a fetch toute les info du client actuellement connecter 
class Customer {
  final int idCust;
  final int pointsCust;
  final String firstNameCust;
  final String lastNameCust;
  final String phoneCust;
  final DateTime registerDateCust;

  Customer( {
    required this.idCust,
    required this.pointsCust,
    required this.firstNameCust,
    required this.lastNameCust,
    required this.phoneCust,
    required this.registerDateCust
  });
}
