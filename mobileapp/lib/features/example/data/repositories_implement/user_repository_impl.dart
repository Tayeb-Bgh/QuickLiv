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
    print('[DEBUG] Début de getUsersWithHobies()');

    // 1. Fetch users
    print('[DEBUG] Appel de fetchUsers()...');
    final List<UserModel> usersList = await userService.fetchUsers();
   
    print(
      '[DEBUG] Reçu ${usersList.length} utilisateurs: ${usersList.map((u) => u.idUser).toList()}',
    );

    if (usersList.isEmpty) {
      print('[DEBUG] Aucun utilisateur trouvé, retourne liste vide');
      return [];
    }

    // 2. Fetch hobbies for each user

    final List<Future<List<HobieModel>>> hobiesListFutures =
        usersList.map((user) {
          
          return userService
              .fetchHobiesByUserId(user.idUser)
              .then((hobies) {
                print(
                  '[DEBUG] Reçu ${hobies.length} hobbies pour user ${user.idUser}',
                );
                return hobies;
              })
              .catchError((e) {
                print(
                  '[ERROR] Erreur fetching hobbies pour user ${user.idUser}: $e',
                );
                return <HobieModel>[];
              });
        }).toList();

    print('[DEBUG] Attente des résultats des hobbies...');
    final List<List<HobieModel>> hobiesList = await Future.wait(
      hobiesListFutures,
    );
    print('[DEBUG] Tous les hobbies ont été reçus');

    // 3. Convert models to entities
    print('[DEBUG] Conversion des modèles en entités...');
    final List<List<HobieEntity>> hobieEntitiesList =
        hobiesList.map((hobies) {
          print('[DEBUG] Conversion de ${hobies.length} hobbies');
          return hobies.map((hobie) => hobie.toEntity()).toList();
        }).toList();

    // 4. Combine users with their hobbies
    print('[DEBUG] Combinaison utilisateurs avec leurs hobbies...');
    final List<UserEntity> userEntitiesList = [];

    for (var i = 0; i < usersList.length; i++) {
      print(
        '[DEBUG] Traitement user ${usersList[i].idUser} avec ${hobieEntitiesList[i].length} hobbies',
      );
      userEntitiesList.add(usersList[i].toEntity(hobieEntitiesList[i]));
    }

    print('[DEBUG] Retourne ${userEntitiesList.length} UserEntity');
    return userEntitiesList;
  }
}
