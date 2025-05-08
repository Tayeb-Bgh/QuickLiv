import 'package:hive/hive.dart';
import 'package:mobileapp/features/customer/cart_popup/data/models/product_hive_object.dart';

part 'cart_hive_object.g.dart';

@HiveType(typeId: 3)
class Cart extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double delPrice;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String pic;

  @HiveField(4)
  final List<Product> prod;

  Cart({
    required this.id,
    required this.delPrice,
    required this.name,
    required this.pic,
    required this.prod,
  });
}
