import 'package:mobileapp/features/customer/cart_popup/business/entities/cart_entity.dart';
import 'package:mobileapp/features/customer/coupons_store/business/entities/coupon_entitie.dart';
import 'package:mobileapp/features/customer/favourites/business/entities/business_entity.dart';
import 'package:mobileapp/features/customer/orders_history/business/entities/order_history_entity.dart';

class Customer {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final DateTime registerDate;
  final int points;
  final bool isSubmittedDeliverer;
  final bool isSubmittedPartner;
  
  final List<Cart> carts;
  final List<Business> favorites;
  final List<OrderHistory> ordersHistory;
  final List<CouponEntity> coupons;

  Customer({required this.id, required this.firstName, required this.lastName, required this.phone, required this.registerDate, required this.points, required this.isSubmittedDeliverer, required this.isSubmittedPartner, required this.carts, required this.favorites, required this.ordersHistory, required this.coupons});
  
  @override
  String toString() {
    return 'Customer{id: $id, firstName: $firstName, lastName: $lastName, phone: $phone, registerDate: $registerDate, points: $points, isSubmittedDeliverer: $isSubmittedDeliverer, isSubmittedPartner: $isSubmittedPartner, carts: $carts, favorites: $favorites, ordersHistory: $ordersHistory, coupons: $coupons}';
  }
  
}