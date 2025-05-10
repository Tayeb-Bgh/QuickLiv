import 'package:mobileapp/features/customer/cart_popup/business/entities/cart_entity.dart';
import 'package:mobileapp/features/customer/payment/Data/models/coupon_model.dart';
import 'package:mobileapp/features/customer/payment/data/repositories/payment_repository_impl.dart';

class InsertOrder {
  final PaymentRepositoryImpl paymentRepository;

  InsertOrder({required this.paymentRepository});

  Future<bool> call(
    Cart cart,
    CouponModel? coupon,
    double lat,
    double lng,
    double deliveryPrice,
    int? transNbr,
  ) {
    return paymentRepository.addOrder(
      cart,
      coupon,
      lat,
      lng,
      deliveryPrice,
      transNbr,
    );
  }
}
