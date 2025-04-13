import 'package:mobileapp/features/customer/research/business/entities/product_entity.dart';


class Shop {
  final int id;
  final String name;
  final String desc;
  final String imgUrl;
  final String phone;
  final String instaUrl;
  final String fcbUrl;

  final double rating;
  final double deliveryPrice;
  final DateTime deliveryTime;
  final bool open;
  final List<Product> productsList;

  Shop({
    required this.id,
    required this.name,
    required this.desc,
    required this.imgUrl,
    required this.phone,
    required this.instaUrl,
    required this.fcbUrl,
    required this.rating,
    required this.deliveryPrice,
    required this.deliveryTime,
    required this.open,
    required this.productsList,
  });
}
