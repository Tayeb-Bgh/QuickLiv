class Product {
  final int id;
  final String name;
  final String category;
  final String desc;
  final String imgUrl;
  final bool unit;
  final int idBusns;
  final double price;
  final double? priceWithReduc;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.desc,
    required this.imgUrl,
    required this.unit,
    required this.idBusns,
    required this.price,
    required this.priceWithReduc,
  });

  static double calculPriceWithReduc(double price, double reduc) {
    return price - price * (reduc / 100);
  }
}
