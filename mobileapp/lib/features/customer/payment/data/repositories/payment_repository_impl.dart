import 'package:mobileapp/features/customer/cart_popup/business/entities/cart_entity.dart';
import 'package:mobileapp/features/customer/payment/Data/models/coupon_model.dart';
import 'package:mobileapp/features/customer/payment/data/models/order_model.dart';
import 'package:mobileapp/features/customer/payment/data/services/payment_service.dart';
import 'package:mobileapp/features/customer/cart_popup/business/entities/product_cart.dart';

class PaymentRepositoryImpl {
  PaymentService paymentService;
  PaymentRepositoryImpl({required this.paymentService});

  Future<int> insertCart(Cart cart) async {
    final int idCart = await paymentService.insertCart(cart.toJson());

    for (final prod in cart.products) {
      try {
        await paymentService.insertProductCart(prod.toJson(idCart));
      } catch (e) {
        print(e);
      }
    }

    return idCart;
  }

  Future<bool> addOrder(
    Cart cart,
    CouponModel? coupon,
    double lat,
    double lng,
    double deliveryPrice,
    int? transNbr,
  ) async {
    int idCart = await insertCart(cart);

    final Map<String, dynamic> mistralJson = toMistralJson(cart.products);

    final String mistralResponse = await paymentService.getMistralResponse(
      mistralJson,
    );
    final String deliveryMethod = extractFirstVehicle(mistralResponse);

    OrderModel order = OrderModel(
      idCartOrd: idCart,
      idCouponOrd: coupon?.idCoupon,
      delivPriceOrd: deliveryPrice,
      weightCatOrd: deliveryMethod,
      custLatOrd: lat,
      custLngOrd: lng,
      transNbrOrd: transNbr,
    );

    print("[AAAAAAAAAAAAAAA]");
    print(order.toJson());

    await paymentService.insertOrder(order.toJson());

    if (coupon != null) {
      await paymentService.updateCouponStatus(coupon.idCoupon);
    }

    return true;
  }

  String extractFirstVehicle(String input) {
    final firstWord = input.trim().split(RegExp(r'\s+')).first.toLowerCase();

    if (firstWord == 'scooter' || firstWord == 'car') {
      return firstWord.toUpperCase();
    }

    return "scooter";
  }

  Map<String, dynamic> toMistralJson(List<ProductCart> productsList) {
    return {
      "items":
          productsList.map((product) {
            return {
              "name": product.name,
              "quantity": product.quantity,
              "unit": product.unitProd,
            };
          }).toList(),
    };
  }
}
