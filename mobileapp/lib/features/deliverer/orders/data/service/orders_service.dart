import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/auth/presentation/providers/auth_provider.dart';
import 'package:mobileapp/features/deliverer/orders/business/entities/product_entity.dart';
import 'package:mobileapp/features/deliverer/orders/data/models/order_model.dart';
import 'package:mobileapp/features/deliverer/orders/data/models/product_model.dart';

class OrdersService {
  final Dio dio;
  final Ref ref;
  OrdersService({required this.dio, required this.ref});
  Future<List<OrderModel>> fetchAllOrders() async {
    final url = await ApiConfig.getBaseUrl();
    final secureStorage = ref.watch(secureStorageProvider);
    String? token = await secureStorage.read(key: 'authToken');

    final response = await dio.get(
      '$url/deliverer/orders',
      options: Options(
        headers: {'authorization': 'Bearer $token'},
        sendTimeout: Duration(seconds: 8),
        receiveTimeout: Duration(seconds: 8),
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      final orders = data.map((e) => OrderModel.fromJson(e)).toList();
      log('Fetched ${orders.length} orders');
      return orders;
    } else {
      throw Exception('Failed to load orders: ${response.statusCode}');
    }
  }

  Future<List<ProductInOrder>> fetchProductsForOrder(int idOrd) async {
    final url = await ApiConfig.getBaseUrl();
    final secureStorage = ref.watch(secureStorageProvider);
    String? token = await secureStorage.read(key: 'authToken');

    final response = await dio.get(
      '$url/deliverer/order/products/$idOrd',
      options: Options(
        headers: {'authorization': 'Bearer $token'},
        sendTimeout: Duration(seconds: 8),
        receiveTimeout: Duration(seconds: 8),
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['products'];
      final products = data.map((e) => ProductInOrder.fromJson(e)).toList();
      log('Fetched ${products.length} products for order $idOrd');
      return products;
    } else {
      throw Exception(
        'Failed to load products for order $idOrd: ${response.statusCode}',
      );
    }
  }
}
