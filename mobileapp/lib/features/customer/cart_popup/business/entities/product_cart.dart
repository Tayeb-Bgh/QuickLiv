class ProductCart {
  final int id;
  final String name;
  final String description;
  final String imgUrl;
  final double price;
  final bool unitProd;
  final int quantity;
  final String notice;

  ProductCart({
    required this.notice,
    required this.id,
    required this.name,
    required this.description,
    required this.imgUrl,
    required this.price,
    required this.unitProd,
    required this.quantity,
  });
}
