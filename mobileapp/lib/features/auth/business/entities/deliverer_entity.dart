// Entity qui est senser servir a fetch toute les info du livreur actuellement connecter 
class Deliverer {
  final int idDel;
  final String emailDel;
  final String adrsDel;
  final String licenseDel;
  final String imgUrlDel;
  final String firestNameDel;
  final String lastNameDel;
  final String phoneDel;
  final double starNbrDel;
  final int deliveryTotalNbrDel;
  final DateTime registerDateDel;

  Deliverer({
    required this.idDel,
    required this.emailDel,
    required this.adrsDel,
    required this.licenseDel,
    required this.imgUrlDel,
    required this.firestNameDel,
    required this.lastNameDel,
    required this.phoneDel,
    required this.starNbrDel,
    required this.deliveryTotalNbrDel,
    required this.registerDateDel
  });
}
