// domain/repositories/points_repository.dart
import 'package:mobileapp/features/customer/coupons_store/business/entities/Customer_entitie.dart';


abstract class CustomerPointsRepository {
  Future<CustomerPointsEntity> getCustomerPoints();
  Future<void> updateCustomerPoints(int customerPoints);
}