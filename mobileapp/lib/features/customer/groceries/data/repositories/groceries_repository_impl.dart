import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/groceries/business/repositories/groceries_repository.dart';
import 'package:mobileapp/features/customer/groceries/data/models/business_model.dart';
import 'package:mobileapp/features/customer/groceries/data/services/groceries_service.dart';

class GroceriesRepositoryImpl implements GroceriesRepository {
  final GroceriesService groceriesService;

  GroceriesRepositoryImpl({required this.groceriesService});

  @override
  Future<List<Grocery>> getGroceries() async {
    Future<List<BusinessModel>> groceriesModelListFuture =
        groceriesService.fetchGroceriesModel();

    // TODO: implement getGroceries
    return List.empty();
  }
}
