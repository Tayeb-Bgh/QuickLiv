import 'package:dio/dio.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/customer/home/data/models/product_business.dart';
import 'package:mobileapp/features/customer/home/data/models/product_model.dart';

class HomeService {
  final Dio dio;

  HomeService({required this.dio});

  Future<List<ProductBusinessModel>> fetchBestReductions(int id) async {
    try {
      final String url = await ApiConfig.getBaseUrl();
      final String urlWithOpts = '$url/home/businesses/$id/products';

      final response = await dio.get(urlWithOpts);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        print("[DEBUG] REDUCTIONS :  $data");

        return data.map((el) => ProductBusinessModel.fromJson(el)).toList();
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductModel> getProductByid(int id) async {
    try {
      final String url = await ApiConfig.getBaseUrl();
      final String urlWithOpts = '$url/home/products/$id';

      final response = await dio.get(urlWithOpts);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        print("[DEBUG] PRODUCT :  $data");

        return data.map((el) => ProductModel.fromJson(el)).toList().first;
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }
}
