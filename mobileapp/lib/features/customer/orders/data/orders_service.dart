import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/customer/orders/business/entities/business_entity.dart';
import 'package:mobileapp/features/customer/orders/business/entities/deliverer_entity.dart';
import 'package:mobileapp/features/customer/orders/business/entities/order_entity.dart';
import 'package:mobileapp/features/customer/orders/business/entities/product_entity.dart';

class OrdersService {
  final Dio dio;

  OrdersService(this.dio);

  Future<Order> getOrderDetails(int orderId) async {
    try {
      final url = await ApiConfig.getBaseUrl();

      final response = await dio.get(
        '$url/orders/details/$orderId',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return _parseOrder(data);
      } else if (response.statusCode == 404) {
        throw Exception('Order not found');
      } else {
        throw Exception(
          'Failed to load order details: status ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  // Nouvelle méthode pour récupérer seulement les IDs des commandes
  Future<List<int>> getCustomerOrderIds(String authToken) async {
    try {
      final url = await ApiConfig.getBaseUrl();
      log(url);
      final response = await dio.get(
        '$url/orders/customer-orders-ids',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $authToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        log("id recuperer avec succes");
        return (response.data as List).cast<int>();
      } else {
        throw Exception(
          'Failed to load customer order IDs: status ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Order _parseOrder(Map<String, dynamic> data) {
    try {
      return Order(
        id: data['id'],
        status: data['status'],
        createdAt: DateTime.parse(data['createdAt']),
        totalAmount: data['totalAmount'].toDouble(),
        priceWithReduc: data['priceWithReduc']?.toDouble(),
        deliveryPrice: data['deliveryPrice'].toDouble(),
        paymentMethod: data['paymentMethod'],
        business: Business(
          id: data['business']['id'],
          name: data['business']['name'],
          imgUrl: data['business']['imgUrl'],
        ),
        deliverer:
            data['deliverer'] != null
                ? Deliverer(
                  id: data['deliverer']['id'],
                  firstName: data['deliverer']['firstName'],
                  lastName: data['deliverer']['lastName'],
                  phoneNumber: data['deliverer']['phoneNumber'],
                  imgUrl: data['deliverer']['imgUrl'],
                )
                : null,
        products:
            (data['products'] as List)
                .map(
                  (p) => Product(
                    id: p['id'],
                    name: p['name'],
                    price: p['price'].toDouble(),
                    quantity: p['quantity'],
                    unit: p['unit'] == 0 ? false : true,
                    notice: p['notice'] ?? "",
                  ),
                )
                .toList(),
        ratingBusns: data['ratingBusns'],
        ratingDel: data['ratingDel'],
        delivererLocation:
            data['delivererLocation'] != null
                ? LatLng(
                  data['delivererLocation']['lat'],
                  data['delivererLocation']['lng'],
                )
                : null,
        customerLocation: LatLng(
          data['customerLocation']['lat'],
          data['customerLocation']['lng'],
        ),
        pointWon: data['pointWon'],
      );
    } catch (e, stack) {
      log('Erreur lors du parsing de la commande', error: e, stackTrace: stack);
      rethrow;
    }
  }
}
