import 'package:mobileapp/features/example/business/entities/hobie_entity.dart';

import '../../business/entities/user_entity.dart';

class UserModel {
  final int idUser;
  final String username;
  final String role;
  final DateTime birthDate;
  final String imgUrl;

  UserModel({required this.idUser, required this.username, required this.role, required this.birthDate, required this.imgUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idUser: json['idUser'],
      username: json['username'],
      role: json['role'],
      birthDate: DateTime.parse(json['birthDate']),
      imgUrl: json['imgUrl']
    );
  }

  Map<String, dynamic> toJson() {
    return {'idUser': idUser, 'username': username, 'role': role,  'birthDate':birthDate};
  }

  UserEntity toEntity(List<HobieEntity> hobies) {
    return UserEntity(
      id: idUser,
      username: username,
      role: role,
      age: UserEntity.calculateAge(birthDate),
      imgUrl: imgUrl,
      hobies: hobies
    );
  }
}
