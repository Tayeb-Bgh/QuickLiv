import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobileapp/features/auth/business/entities/deliverer_entity.dart';
import 'package:mobileapp/features/auth/business/repositories/auth_repository_abstr.dart';

class GetDelivererInfoUsecase {
  final AuthRepository repository;

  GetDelivererInfoUsecase(this.repository);

  Future<Deliverer> call({required String phoneNumber, required String token, required FlutterSecureStorage secureStorage}) {
    return repository.getDelivererInfo(phoneNumber:phoneNumber);
  }
}
