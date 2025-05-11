class Product {
  final int idProd;
  final int idBusns;
  final String name;
  final String imgUrl;
  final double price;
  final double? reducRate;
  final bool unit;
  final int? qttyStock;
  final String descr;
  Product({
    required this.idProd,
    required this.idBusns,
    required this.name,
    required this.imgUrl,
    required this.price,
    required this.unit,
    required this.descr,
    this.reducRate,
    this.qttyStock,
  });
}
