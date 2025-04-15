import 'package:mobileapp/features/auth/business/repositories/auth_repository_abstr.dart';
import 'package:mobileapp/features/auth/data/service/auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService service;

  AuthRepositoryImpl(this.service);

  @override
  Future<bool> checkPhoneNumber(String phoneNumber) async {
    return await service.checkPhoneNumber(phoneNumber);
  }
}
