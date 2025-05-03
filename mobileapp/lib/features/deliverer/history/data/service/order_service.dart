import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order_history_model.dart';

class RemoteDataSource {
  final String baseUrl;

  RemoteDataSource(this.baseUrl);

  Future<List<CompleteOrderModel>> fetchCompleteOrders() async {
    try {
      print('Fetching orders from $baseUrl/orders');
      final orderResponse = await http.get(Uri.parse('$baseUrl/orders'));
      if (orderResponse.statusCode != 200) {
        print(
          'Error: Failed to fetch orders. Status code: ${orderResponse.statusCode}',
        );
        throw Exception('Error while fetching the orders');
      }

      final ordersData = json.decode(orderResponse.body)['data'] as List;

      List<CompleteOrderModel> completeOrders = [];
      for (var orderData in ordersData) {
        final int idOrd = orderData['idOrd'];

        final customerResponse = await http.get(
          Uri.parse('$baseUrl/customer/$idOrd'),
        );
        if (customerResponse.statusCode != 200) {
          throw Exception('Error while fetching the customer');
        }
        final customerData = json.decode(customerResponse.body)['data'];

        if (customerData == null || !customerData.containsKey('idBusnsCart')) {
          print('Error: Customer data is invalid or missing idBusnsCart');
          throw Exception('Customer data is invalid or missing idBusnsCart');
        }

        final businessId = customerData['idBusnsCart'];

        final businessResponse = await http.get(
          Uri.parse('$baseUrl/business/$businessId'),
        );
        if (businessResponse.statusCode != 200) {
          throw Exception('Error while fetching the business');
        }
        final businessData = json.decode(businessResponse.body)['data'];

        final productsResponse = await http.get(
          Uri.parse('$baseUrl/products/$idOrd'),
        );
        if (productsResponse.statusCode != 200) {
          throw Exception('Error while fetching the products');
        }
        final productsData = json.decode(productsResponse.body)['data'];

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
