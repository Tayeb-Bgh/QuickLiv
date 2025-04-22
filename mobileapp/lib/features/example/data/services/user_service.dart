import 'package:dio/dio.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';

import 'package:mobileapp/features/example/data/models/hobie_model.dart';
import '../models/user_model.dart';

class UserService {
  final Dio dio;

  UserService(this.dio);

  Future<List<UserModel>> fetchUsers() async {
    try {
      final url = await ApiConfig.getBaseUrl();

      final response = await dio.get(
        '$url/example/users',
        options: Options(
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

      if (response.statusCode == 200) {
        List data = response.data;
        return data.map((e) => UserModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load users: status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<HobieModel>> fetchHobiesByUserId(int idUser) async {
    try {
      final url = await ApiConfig.getBaseUrl();

      final response = await dio.get(
        '$url/example/hobies/$idUser',
        options: Options(
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

      if (response.statusCode == 200) {
        List data = response.data;
        return data.map((e) => HobieModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load hobies: status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
