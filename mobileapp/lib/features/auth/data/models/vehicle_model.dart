class VehicleModel {
  final int idVehcl;
  final String nbrVehcl;
  final String vinNbrVehcl;
  final String typeVehcl;

  VehicleModel({
    required this.idVehcl,
    required this.nbrVehcl,
    required this.vinNbrVehcl,
    required this.typeVehcl,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      idVehcl: json["idVehcl"],
      nbrVehcl: json["nbrVehcl"],
      vinNbrVehcl: json["vinNbrVehcl"],
      typeVehcl: json["typeVehcl"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idVehcl": idVehcl,
      "nbrVehcl": nbrVehcl,
      "vinNbrVehcl": vinNbrVehcl,
      "typeVehcl": typeVehcl,
    };
  }
}
