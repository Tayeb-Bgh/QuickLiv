class Product {
  final int idProd;
  final int idBusns;
  final String nameProd;
  final String nameBusns;
  final String description;
  final String imgUrl;
  final bool unit;
  final double price;
  final int delivDuration;

  Product({
    required this.idProd,
    required this.idBusns,
    required this.nameProd,
    required this.nameBusns,
    required this.imgUrl,
    required this.delivDuration,
    required this.price,
    required this.description,
    required this.unit,
  });
}
