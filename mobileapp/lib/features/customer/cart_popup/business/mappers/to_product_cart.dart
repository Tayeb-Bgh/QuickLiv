import 'package:mobileapp/features/customer/cart_popup/business/entities/product_cart.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/product_with_reduc_entity.dart';
import 'package:mobileapp/features/customer/grocery_opened/business/entities/product_entity.dart'
    as product_gro;
import 'package:mobileapp/features/customer/restaurant_opened/business/entities/product_entity.dart'
    as product_op_rest;
import 'package:mobileapp/features/customer/restaurants/business/entities/product_entity.dart'
    as product_rest;

class ToProductCart {
  static ProductCart fromProductWithReduc(
    ProductWithReduc product,
    int quantity,
  ) {
    return ProductCart(
      id: product.idProd,
      name: product.nameProd,
      description: product.description,
      imgUrl: product.imgUrl,
      price: product.priceWithReduc,
      unitProd: product.unit,
      quantity: quantity,
      notice: '',
    );
  }

  static ProductCart fromProductGro(product_gro.Product product, int quantity) {
    return ProductCart(
      id: product.idProd,
      name: product.name,
      description: product.description,
      imgUrl: product.imgUrl,
      price: product.priceWithReduc ?? product.price,
      unitProd: product.unit,
      quantity: quantity,
      notice: '',
    );
  }

  static ProductCart fromProductRest({
    required product_rest.Product product,

    int quantity = 1,
  }) {
    return ProductCart(
      id: product.idProd,
      name: product.nameProd,
      description: product.description,
      imgUrl: product.imgUrl,
      price: product.price,
      unitProd: product.unit,
      quantity: quantity,
      notice: '',
    );
  }

  static ProductCart fromProductOpRest({
    required product_op_rest.Product product,

    int quantity = 1,
  }) {
    return ProductCart(
      id: product.id,
      name: product.name,
      description: product.desc,
      imgUrl: product.imgUrl,
      price: product.priceWithReduc ?? product.price,
      unitProd: product.unit,
      quantity: quantity,
      notice: '',
    );
  }
}
