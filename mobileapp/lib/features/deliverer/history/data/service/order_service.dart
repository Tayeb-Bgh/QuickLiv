import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/auth/presentation/providers/auth_provider.dart';
import '../models/order_history_model.dart';

class RemoteDataSource {
  final Dio dio;
  final Ref ref;

  RemoteDataSource(this.dio, this.ref);

  Future<List<CompleteOrderModel>> fetchCompleteOrders() async {
    try {
      final url = await ApiConfig.getBaseUrl();
      final token = await ref.read(jwtTokenProvider.future);

      final orderResponse = await dio.get(
        '$url/deliverer/history',
        options: Options(headers: {'authorization': 'Bearer $token'}),
      );
      if (orderResponse.statusCode != 200) {
        throw Exception('Error while fetching the orders');
      }

      final ordersData = orderResponse.data['data'] as List;

      List<CompleteOrderModel> completeOrders = [];
      for (var orderData in ordersData) {
        final int idOrd = orderData['idOrd'];

        final customerResponse = await dio.get(
          '$url/deliverer/customer/$idOrd',
          options: Options(headers: {'authorization': 'Bearer $token'}),
        );
        if (customerResponse.statusCode != 200) {
          throw Exception('Error while fetching the customer');
        }
        final customerData = customerResponse.data['data'];

        if (customerData == null || !customerData.containsKey('idBusnsCart')) {
          throw Exception('Customer data is invalid or missing idBusnsCart');
        }

        final businessId = customerData['idBusnsCart'];

        final businessResponse = await dio.get(
          '$url/deliverer/business/$businessId',
          options: Options(headers: {'authorization': 'Bearer $token'}),
        );
        if (businessResponse.statusCode != 200) {
          throw Exception('Error while fetching the business');
        }
        final businessData = businessResponse.data['data'];

        final productsResponse = await dio.get(
          '$url/deliverer/products/$idOrd',
          options: Options(headers: {'authorization': 'Bearer $token'}),
        );
        if (productsResponse.statusCode != 200) {
          throw Exception('Error while fetching the products');
        }
        final productsData = productsResponse.data['data'];

        completeOrders.add(
          CompleteOrderModel(
            order: OrderModel.fromJson(orderData),
            customer: CustomerModel.fromJson(customerData),
            business: BusinessModel.fromJson(businessData),
            productResponse: ProductResponseModel.fromJson(productsData),
          ),
        );
      }

      return completeOrders;
    } catch (e) {
      throw Exception('Error while fetching the complete orders: $e');
    }
  }
}
