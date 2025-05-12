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

  Future<OrderModel?> fetchOrderForDeliverer() async {
    final url = await ApiConfig.getBaseUrl();
    final secureStorage = ref.watch(secureStorageProvider);
    String? token = await secureStorage.read(key: 'authToken');

    final response = await dio.get(
      '$url/deliverer/order',
      options: Options(
        headers: {'authorization': 'Bearer $token'},
        sendTimeout: Duration(seconds: 8),
        receiveTimeout: Duration(seconds: 8),
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;

      if (data.isEmpty) return null;

      final order = OrderModel.fromJson(data[0]);
      return order;
    } else {
      throw Exception('Failed to load orders: ${response.statusCode}');
    }
  }

  Future<void> assignOrderToDeliverer(int orderId) async {
    final url = await ApiConfig.getBaseUrl();
    final secureStorage = ref.watch(secureStorageProvider);
    String? token = await secureStorage.read(key: 'authToken');
    log('u are in assignOrder');
    final response = await dio.post(
      '$url/deliverer/order/assign/$orderId',
      options: Options(
        headers: {'authorization': 'Bearer $token'},
        sendTimeout: Duration(seconds: 8),
        receiveTimeout: Duration(seconds: 8),
      ),
    );

    if (response.statusCode == 200) {
      log('Order $orderId successfully assigned to deliverer');
    } else {
      throw Exception('Failed to assign order: ${response.statusCode}');
    }
  }

  Future<void> updateOrderStatus({
    required int orderId,
    required String status,
  }) async {
    final url = await ApiConfig.getBaseUrl();
    final secureStorage = ref.watch(secureStorageProvider);
    String? token = await secureStorage.read(key: 'authToken');
    try {
      final response = await dio.put(
        '$url/deliverer/orders/$orderId',
        data: {'statusOrd': status},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          sendTimeout: const Duration(seconds: 8),
          receiveTimeout: const Duration(seconds: 8),
        ),
      );

      if (response.statusCode == 200) {
        log("Order status updated successfully.");
      } else {
        throw Exception('Failed to update order: ${response.statusCode}');
      }
    } on DioException catch (e) {
      log("DioException: ${e.message}");
      throw Exception(
        'Dio error while updating order status: ${e.response?.data}',
      );
    }
  }

  Future<void> updateOrderStatusLanLng({
    required int orderId,
    required String status,
    required double lan,
    required double lng,
  }) async {
    final url = await ApiConfig.getBaseUrl();
    final secureStorage = ref.watch(secureStorageProvider);
    String? token = await secureStorage.read(key: 'authToken');
    try {
      log('u are trying to update the status o=with lan and lng');
      final response = await dio.put(
        '$url/deliverer/ordersLanLng/$orderId',
        data: {'statusOrd': status, 'lanDel': lan, 'lngDel': lng},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          sendTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 20),
        ),
      );

      if (response.statusCode == 200) {
        log("Order status updated successfully.");
      } else {
        throw Exception('Failed to update order: ${response.statusCode}');
      }
    } on DioException catch (e) {
      log("DioException: ${e.message}");
      throw Exception(
        'Dio error while updating order status: ${e.response?.data}',
      );
    }
  }
}
