class ProductBusinessModel {
  final int idProd;
  final int idBusns;
  final double priceProdBusns;
  final double reducRateProdBusns;

  ProductBusinessModel({
    required this.idProd,
    required this.idBusns,
    required this.priceProdBusns,
    required this.reducRateProdBusns,
  });

  factory ProductBusinessModel.fromJson(Map<String, dynamic> json) {
    return ProductBusinessModel(
      idProd: json["idProd"],
      idBusns: json["idBusns"],
      priceProdBusns: json["priceProdBusns"],
      reducRateProdBusns: json["reducRateProdBusns"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idProd": idProd,
      "idBusns": idBusns,
      "priceProdBusns": priceProdBusns,
      "reducRateProdBusns": reducRateProdBusns,
    };
  }
}
