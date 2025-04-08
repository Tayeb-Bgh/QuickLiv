import 'package:mobileapp/features/example/business/entities/hobie_entity.dart';

class UserEntity {
  final int id;
  final String username;
  final String role;
  final String imgUrl;

  final int age;
  final List<HobieEntity> hobies;

  UserEntity({
    required this.id,
    required this.username,
    required this.role,
    required this.age,
    required this.hobies,
    required this.imgUrl
  });

  static int calculateAge(DateTime birthDate) {
    return DateTime.now().difference(birthDate).inDays ~/ 365;
  }
}
