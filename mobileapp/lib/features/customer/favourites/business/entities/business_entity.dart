class Business{
  final int id;
  final String name;
  final String desc;
  final String type;
  final bool liked;
  final int deliveryTime;
  final double deliveryPrice;
  final double rating;
  final bool open;
  final String? imgUrlBusns;

  Business({
    required this.id,
    required this.name,
    required this.desc,
    required this.type,
    required this.liked,
    required this.deliveryTime,
    required this.deliveryPrice,
    required this.rating,
    required this.open,
    required this.imgUrlBusns,
  });
}
