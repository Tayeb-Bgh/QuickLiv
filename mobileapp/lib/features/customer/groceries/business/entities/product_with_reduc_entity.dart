class ProductWithReduc {
  final int idProd;
  final int idBusns;
  final String nameProd;
  final double reducRate;
  final String nameBusns;
  final String imgUrl;

  final double delivPrice;
  final double delivPriceWithReduc;
  final int delivDuration;

  ProductWithReduc({
    required this.idProd,
    required this.idBusns,
    required this.nameProd,
    required this.nameBusns,
    required this.imgUrl,
    required this.reducRate,
    required this.delivDuration,
    required this.delivPrice,
    required this.delivPriceWithReduc,
  });
}
