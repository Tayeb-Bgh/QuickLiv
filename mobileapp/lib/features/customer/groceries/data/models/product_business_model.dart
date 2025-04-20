class ProductBusinessModel {
  final int idProd;
  final int idBusns;
  final double reducRateProdBusns;
  final double priceProdBusns;

  ProductBusinessModel({
    required this.idBusns,
    required this.idProd,
    required this.priceProdBusns,
    required this.reducRateProdBusns,
  });

  factory ProductBusinessModel.fromJson(Map<String, dynamic> json) {
    return ProductBusinessModel(
      idBusns: json["idBusns"],
      idProd: json["idProd"],
      priceProdBusns: json["priceProdBusns"].toDouble(),
      reducRateProdBusns: json["reducRateProdBusns"].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idBusns": idBusns,
      "idProd": idProd,
      "priceProdBusns": priceProdBusns.toDouble(),
      "reducRateProdBusns": reducRateProdBusns.toDouble(),
    };
  }
}
