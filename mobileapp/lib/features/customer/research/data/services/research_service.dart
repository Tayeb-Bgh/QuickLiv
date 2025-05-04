import 'package:dio/dio.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/customer/research/data/models/business_model.dart';
import 'package:mobileapp/features/customer/research/data/models/product_business_model.dart';
import 'package:mobileapp/features/customer/research/data/models/product_model.dart';

class ResearchService {
  final Dio dio;

  ResearchService({required this.dio});

  Future<List<BusinessModel>> fetchBusinessesByKeyWord(String keyWord) async {
    try {
      String url = await ApiConfig.getBaseUrl();
      String urlWithOptions = "$url/research/business?search=$keyWord";

      final response = await dio.get(urlWithOptions);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        return data.map((elem) => BusinessModel.fromJson(elem)).toList();
      } else {
        throw Error();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductBusinessModel>> fetchBusinessProducts(
    int id,
    String keyWord,
  ) async {
    try {
      String url = await ApiConfig.getBaseUrl();
      String urlWithOptions =
          "$url/research/business/$id/products?search=$keyWord";

      final response = await dio.get(urlWithOptions);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        return data.map((elem) => ProductBusinessModel.fromJson(elem)).toList();
      } else {
        throw Error();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductModel>> fetchProductById(int id) async {
    try {
      String url = await ApiConfig.getBaseUrl();
      String urlWithOptions = "$url/research/business/products/$id";

      final response = await dio.get(urlWithOptions);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        return data.map((elem) => ProductModel.fromJson(elem)).toList();
      } else {
        throw Error();
      }
    } catch (e) {
      rethrow;
    }
  }
}
