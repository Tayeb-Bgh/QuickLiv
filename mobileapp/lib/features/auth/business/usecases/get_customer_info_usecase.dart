import 'package:mobileapp/features/auth/business/entities/customer_entity.dart';
import 'package:mobileapp/features/auth/business/repositories/auth_repository_abstr.dart';

class GetCustomerInfoUseCase {
  final AuthRepository repository;

  GetCustomerInfoUseCase(this.repository);

  Future<Customer> call({required String phoneNumber}) {
   
    return  repository.getCustomerInfo(
      phoneNumber: phoneNumber,
    );
   
  }
}
