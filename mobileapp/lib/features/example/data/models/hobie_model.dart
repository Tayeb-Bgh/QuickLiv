import 'package:mobileapp/features/example/business/entities/hobie_entity.dart';

class HobieModel {
  final int id;
  final String? name;

  HobieModel({required this.id, required this.name});

  factory HobieModel.fromJson(Map<String, dynamic> json) {
    return HobieModel(
      id: json['idHobie'],
      name: json['nameHobie'],
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idHobie': id,
      'nameHobie': name,
    };
  }

   Hobie toEntity() {
    return Hobie(
      id: id,
      name: name,
    );
  }
}
