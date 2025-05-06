class ProductBusinessModel {
  final int idProd;
  final int idBusns;
  final double reducRateProdBusns;

  ProductBusinessModel({
    required this.idProd,
    required this.idBusns,
    required this.reducRateProdBusns,
  });

  factory ProductBusinessModel.fromJson(Map<String, dynamic> json) {
    return ProductBusinessModel(
      idBusns: json["idBusns"],
      idProd: json["idProd"],
      reducRateProdBusns: json['reducRateProdBusns'].toDouble(),
    );
  }
}
