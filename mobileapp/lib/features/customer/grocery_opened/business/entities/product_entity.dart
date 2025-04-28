class Product {
  final int idProd;
  final int idBusns;
  final String name;
  final String description;
  final String category;
  final String secondCategory;
  final String imgUrl;
  final double price;
  final double? reducRate;
  final double? priceWithReduc;
  final int? stockQtty;
  final bool unit;

  Product({
    required this.idProd,
    required this.idBusns,
    required this.name,
    required this.description,
    required this.category,
    required this.secondCategory,
    required this.imgUrl,
    required this.price,
    this.reducRate,
    this.priceWithReduc,
    this.stockQtty,
    required this.unit,
  });
}
