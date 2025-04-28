// domain/usecases/get_customer_points_usecase.dart
import 'package:mobileapp/features/customer/coupons_store/business/entities/Customer_entitie.dart';
import 'package:mobileapp/features/customer/coupons_store/business/repositories/clientPoint_repositorie.dart';


class GetCustomerPointsUseCase {
  final CustomerPointsRepository customerPointsRepository;

  GetCustomerPointsUseCase(this.customerPointsRepository);

  Future<CustomerPointsEntity> call() {
    return customerPointsRepository.getCustomerPoints();
  }
}

class UpdateCustomerPointsUseCase {
  final CustomerPointsRepository customerPointsRepository;

  UpdateCustomerPointsUseCase(this.customerPointsRepository);

  Future<void> call(int points) {
    return customerPointsRepository.updateCustomerPoints(points);
  }
}