import 'package:dio/dio.dart';
import 'package:mobileapp/core/config/api_config.dart';
import '../models/user_model.dart';

class UserService {
  final Dio dio;

  UserService(this.dio);

  Future<List<UserModel>> fetchUsers() async {
    final response = await dio.get('${ApiConfig.baseUrl}/example');

    if (response.statusCode == 200) {
      print(response.data);
      List data = response.data;
      return data.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
