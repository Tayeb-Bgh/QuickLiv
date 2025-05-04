import 'package:mobileapp/features/customer/gesProfil/DevCommercant/business/entities/trader.dart';

class TraderModel extends Trader {
  TraderModel({
    required String nom,
    required String prenom,
    required String dateNais,
    required String adresse,
    required String telephone,
    required String numIdentite,
    required String sexe,
    required String nomCommerce,
    required String adresseCommerce,
    required String telephoneCommerce,
    required String email,
    required String numRegCommerce,
    required String type,
    required String pieceIdentit,
    required String regCommerce,
    required String paieImpots,
    required String autoSanitaire,
  }) : super(
         nom: nom,
         prenom: prenom,
         dateNais: dateNais,
         adresse: adresse,
         telephone: telephone,
         numIdentite: numIdentite,
         sexe: sexe,
         nomCommerce: nomCommerce,
         adresseCommerce: adresseCommerce,
         telephoneCommerce: telephoneCommerce,
         email: email,
         numRegCommerce: numRegCommerce,
         type: type,
         pieceIdentit: pieceIdentit,
         regCommerce: regCommerce,
         paieImpots: paieImpots,
         autoSanitaire: autoSanitaire,
       );

  factory TraderModel.fromJson(Map<String, dynamic> json) {
    return TraderModel(
      nom: json['nom'],
      prenom: json['prenom'],
      dateNais: json['dateNais'],
      adresse: json['adresse'],
      telephone: json['telephone'],
      numIdentite: json['numIdentite'],
      sexe: json['sexe'],
      nomCommerce: json['nomCommerce'],
      adresseCommerce: json['adresseCommerce'],
      telephoneCommerce: json['telephoneCommerce'],
      email: json['email'],
      numRegCommerce: json['numRegCommerce'],
      type: json['type'],
      pieceIdentit: json['pieceIdentit'],
      regCommerce: json['regCommerce'],
      paieImpots: json['paieImpots'],
      autoSanitaire: json['autoSanitaire'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prenom': prenom,
      'dateNais': dateNais,
      'adresse': adresse,
      'telephone': telephone,
      'numIdentite': numIdentite,
      'sexe': sexe,
      'nomCommerce': nomCommerce,
      'adresseCommerce': adresseCommerce,
      'telephoneCommerce': telephoneCommerce,
      'email': email,
      'numRegCommerce': numRegCommerce,
      'type': type,
      'pieceIdentit': pieceIdentit,
      'regCommerce': regCommerce,
      'paieImpots': paieImpots,
      'autoSanitaire': autoSanitaire,
    };
  }

  Trader toEntity() {
    return Trader(
      nom: nom,
      prenom: prenom,
      dateNais: dateNais,
      adresse: adresse,
      telephone: telephone,
      numIdentite: numIdentite,
      sexe: sexe,
      nomCommerce: nomCommerce,
      adresseCommerce: adresseCommerce,
      telephoneCommerce: telephoneCommerce,
      email: email,
      numRegCommerce: numRegCommerce,
      type: type,
      pieceIdentit: pieceIdentit,
      regCommerce: regCommerce,
      paieImpots: paieImpots,
      autoSanitaire: autoSanitaire,
    );
  }
}
