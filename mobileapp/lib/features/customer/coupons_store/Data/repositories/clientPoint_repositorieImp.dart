import 'package:mobileapp/features/customer/coupons_store/Data/services/clientPoint_service.dart';
import 'package:mobileapp/features/customer/coupons_store/business/entities/Customer_entitie.dart';
import 'package:mobileapp/features/customer/coupons_store/business/repositories/clientPoint_repositorie.dart';

class CustomerPointRepositoryImpl implements CustomerPointsRepository {
  final CustomerPointService customerPointService;

  CustomerPointRepositoryImpl(this.customerPointService);

  @override
  Future<CustomerPointsEntity> getCustomerPoints() async {
    try{
    final customerPointModel = await customerPointService.getCustomerPoints();
    return customerPointModel.toEntity();
    }catch(e){
      print('Error in repository when fetching client points: $e');
      throw Exception('Failed to fetch client points: $e');
    }
  }
  
  @override
Future<void> updateCustomerPoints(int customerPoints) async {
    try {
      await customerPointService.updateCustomerPoints(customerPoints);
    } catch (e) {
      print('Error in repository when updating client points: $e');
      throw Exception('Failed to update client points: $e');
    }
  }
  
}