class ProductBusinessModel {
  final int idProd;
  final int idBusns;
  final int? qttyProdBusns;
  final double? reducRateProdBusns;
  final double priceProdBusns;

  ProductBusinessModel({
    required this.idProd,
    required this.idBusns,
    required this.qttyProdBusns,
    required this.priceProdBusns,
    required this.reducRateProdBusns,
  });

  factory ProductBusinessModel.fromJson(Map<String, dynamic> json) {
    return ProductBusinessModel(
      idProd: json["idProd"],
      idBusns: json["idBusns"],
      qttyProdBusns: json["qttyProdBusns"],
      priceProdBusns: json["priceProdBusns"].toDouble(),
      reducRateProdBusns: json["reducRateProdBusns"]?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idProd": idProd,
      "idBusns": idBusns,
      "qttyProdBusns": qttyProdBusns,
      "priceProdBusns": priceProdBusns,
      "reducRateProdBusns": reducRateProdBusns,
    };
  }
}
