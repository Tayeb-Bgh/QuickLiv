import 'package:dio/dio.dart';
import 'package:mobileapp/features/customer/groceries/data/models/business_model.dart';

class GroceriesService {
  final Dio dio;

  GroceriesService({required this.dio});

  Future<List<BusinessModel>> fetchGroceriesModel() async {
    return List<BusinessModel>.empty().toList();
  }
}
