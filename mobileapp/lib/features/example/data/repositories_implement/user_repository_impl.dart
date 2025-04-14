import 'package:mobileapp/features/example/business/entities/hobie_entity.dart';
import 'package:mobileapp/features/example/data/models/hobie_model.dart';
import 'package:mobileapp/features/example/data/models/user_model.dart';

import '../../business/entities/user_entity.dart';
import '../../business/repositories/user_repository.dart';
import '../services/user_service.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService userService;

  UserRepositoryImpl(this.userService);

  @override
  Future<List<UserEntity>> getUsersWithHobies() async {
    final List<UserModel> usersList = await userService.fetchUsers();

    if (usersList.isEmpty) {
      return [];
    }

    final List<Future<List<HobieModel>>> hobiesListFutures =
        usersList.map((user) {
          return userService
              .fetchHobiesByUserId(user.idUser)
              .then((hobies) {
                return hobies;
              })
              .catchError((e) {
                return <HobieModel>[];
              });
        }).toList();

    final List<List<HobieModel>> hobiesList = await Future.wait(
      hobiesListFutures,
    );

    final List<List<Hobie>> hobieEntitiesList =
        hobiesList.map((hobies) {
          return hobies.map((hobie) => hobie.toEntity()).toList();
        }).toList();

    final List<UserEntity> userEntitiesList = [];

    for (var i = 0; i < usersList.length; i++) {
      userEntitiesList.add(usersList[i].toEntity(hobieEntitiesList[i]));
    }

    return userEntitiesList;
  }
}
