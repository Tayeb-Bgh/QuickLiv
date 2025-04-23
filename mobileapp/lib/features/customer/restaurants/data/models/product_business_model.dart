class ProductBusinessModel {
  final int idProd;
  final int idBusns;
  final double priceProdBusns;

  ProductBusinessModel({
    required this.idBusns,
    required this.idProd,
    required this.priceProdBusns,
  });

  factory ProductBusinessModel.fromJson(Map<String, dynamic> json) {
    return ProductBusinessModel(
      idBusns: json["idBusns"],
      idProd: json["idProd"],
      priceProdBusns: json["priceProdBusns"].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idBusns": idBusns,
      "idProd": idProd,
      "priceProdBusns": priceProdBusns.toDouble(),
    };
  }
}
