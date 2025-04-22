class ProductWithReduc {
  final int idProd;
  final int idBusns;
  final String nameProd;
  final double reducRate;
  final String nameBusns;
  final String imgUrl;

  final double price;
  final double priceWithReduc;
  final int delivDuration;

  ProductWithReduc({
    required this.idProd,
    required this.idBusns,
    required this.nameProd,
    required this.nameBusns,
    required this.imgUrl,
    required this.reducRate,
    required this.delivDuration,
    required this.price,
    required this.priceWithReduc,
  });
}
