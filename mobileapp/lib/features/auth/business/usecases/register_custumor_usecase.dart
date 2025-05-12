import 'package:mobileapp/features/auth/business/entities/custumere_entity.dart';
import 'package:mobileapp/features/auth/data/models/customer_model.dart';

import '../entities/customer_entity.dart';
import '../repositories/auth_repository_abstr.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);


  Future<void> call(Customere user) async {
    await repository.registerUser(user);
  }
}
