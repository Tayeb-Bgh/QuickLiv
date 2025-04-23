import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/auth/presentation/providers/auth_provider.dart';
import 'package:mobileapp/features/deliverer/home/data/models/deliverer_status_model.dart';

class DelivererHomeService {
  final Dio dio;

  final Ref ref;

  DelivererHomeService(this.dio, this.ref);

  Future<DelivererStatusModel> getDelivererInfo() async {
    final url = await ApiConfig.getBaseUrl();
    final secureStorage = ref.watch(secureStorageProvider);
    String? token = await secureStorage.read(key: 'authToken');
    print(" |||||||||||| ||||||| |||||||  ||||||the token is $token");
    try {
      final response = await dio.get(
        "$url/deliverer/home",
        options: Options(
          headers: {'authorization': 'Bearer $token'},
          sendTimeout: Duration(seconds: 8),
          receiveTimeout: Duration(seconds: 8),
        ),
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print("the data is $data");
        return DelivererStatusModel.fromJson(data);
      } else {
        throw Exception('Failed to load users: status ${response.statusCode}');
      }
    } catch (e) {
      print("Error checking availability: $e");
      throw Exception("Error fetching deliverer info: $e");
    }
  }

  Future<bool> setAvaibility(bool isOnline) async {
    print('u are about to set the status to $isOnline');
    final url = await ApiConfig.getBaseUrl();
    final secureStorage = ref.watch(secureStorageProvider);
    String? token = await secureStorage.read(key: 'authToken');
    try {
      final response = await dio.put(
        "$url/deliverer/home",
        data: {'status': isOnline},
        options: Options(
          headers: {'authorization': 'Bearer $token'},
          sendTimeout: Duration(seconds: 8),
          receiveTimeout: Duration(seconds: 8),
        ),
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print("the data is $data");
        return true;
      } else {
        throw Exception('Failed to load users: status ${response.statusCode}');
      }
    } catch (e) {
      print("Error checking availability: $e");
      throw Exception("Error fetching deliverer info: $e");
    }
  }
}
