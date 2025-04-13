class Product {
  final int id;
  final String category;
  final String desc;
  final String imgUrl;

  final double price;
  final double priceWithReduc;

  Product({
    required this.id,
    required this.category,
    required this.desc,
    required this.imgUrl,
    required this.price,
    required this.priceWithReduc,
  });

  static double calculPriceWithReduc(double price, double reduc) {
    return price * reduc;
  }
}
