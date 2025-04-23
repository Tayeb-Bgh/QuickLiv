
import 'package:mobileapp/features/auth/business/repositories/auth_repository_abstr.dart';

class CheckPhoneUseCase {
  final AuthRepository repository;

  CheckPhoneUseCase(this.repository);

  Future<bool> call(String phoneNumber) async {
    return await repository.checkPhoneNumber(phoneNumber);
  }
}
