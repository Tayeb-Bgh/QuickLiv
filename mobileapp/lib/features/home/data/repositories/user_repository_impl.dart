
import '../../business/entities/user_entity.dart';
import '../../business/repositories/user_repository.dart';
import '../services/user_service.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService userService;

  UserRepositoryImpl(this.userService);

  @override
  Future<List<UserEntity>> getUsers() async {
    return await userService.fetchUsers();
  }
}
