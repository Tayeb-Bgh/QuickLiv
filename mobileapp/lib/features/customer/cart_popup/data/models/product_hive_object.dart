import 'package:hive/hive.dart';

part 'product_hive_object.g.dart';

@HiveType(typeId: 4)
class Product extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String pic;

  @HiveField(2)
  final String nom;

  @HiveField(3)
  final String descr;

  @HiveField(4)
  final bool unitProd;

  @HiveField(5)
  int poidQuantity;

  @HiveField(6)
  final double prix;
  @HiveField(7)
  String? notice;

  Product({
    required this.id,
    required this.pic,
    required this.nom,
    required this.descr,
    required this.unitProd,
    required this.poidQuantity,
    required this.prix,
  });
}
