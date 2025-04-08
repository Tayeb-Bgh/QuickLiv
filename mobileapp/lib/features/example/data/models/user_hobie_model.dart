class UserHobieModel {
  final int idUserHobie;
  final int idUser;
  final int idHobie;

  UserHobieModel({
    required this.idUserHobie,
    required this.idUser,
    required this.idHobie,
  });

  factory UserHobieModel.fromJson(Map<String, dynamic> json) {
    return UserHobieModel(
      idUserHobie: json['idUserHobie'],
      idUser: json['idUser'],
      idHobie: json['idHobie'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idUserHobie': idUserHobie,
      'idUser': idUser,
      'idHobie': idHobie,
    };
  }
}
