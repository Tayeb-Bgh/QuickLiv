class Restaurant {
  final int id;
  final String name;
  final String desc;
  final String imgUrl;
  final String phone;
  final String instaUrl;
  final String fcbUrl;

  final double deliveryPrice;
  final DateTime deliveryTime;
  final double rating;
  final List<String> categories;

  Restaurant({
    required this.id,
    required this.name,
    required this.desc,
    required this.imgUrl,
    required this.phone,
    required this.instaUrl,
    required this.fcbUrl,
    required this.deliveryPrice,
    required this.deliveryTime,
    required this.rating,
    required this.categories,
  });

  static DateTime calculDeliveryTime(DateTime orderTime, double distance) {
    return DateTime.now();
  }
}
