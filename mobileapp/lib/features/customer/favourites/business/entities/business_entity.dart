class Business{
  final int id;
  final String name;
  final String desc;
  final String type;

  final bool liked;
  final DateTime deliveryTime;
  final double deliveryPrice;
  final double rating;
  final bool open;

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
  });

  static double calculDeliveryPrice(double distance) {
    return 0;
  }

  static DateTime calculDeliveryTime(DateTime orderTime, double distance) {
    return DateTime.now();
  }
}
