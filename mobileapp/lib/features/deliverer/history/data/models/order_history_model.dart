import 'package:mobileapp/features/deliverer/history/business/entities/order_entitie.dart';

class OrderModel {
  final int idOrd;
  final double delivPriceOrd;
  final int? transNbrOrd;
  final DateTime createdAtOrd;
  final String? cancelCommentDel;

  OrderModel({
    required this.idOrd,
    required this.delivPriceOrd,
    required this.transNbrOrd,
    required this.createdAtOrd,
    required this.cancelCommentDel,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      idOrd: json['idOrd'],
      delivPriceOrd: json['delivPriceOrd'].toDouble(),
      transNbrOrd: json['transNbrOrd'],
      createdAtOrd: DateTime.parse(json['createdAtOrd']),
      cancelCommentDel: json['cancelCommentDel'],
    );
  }
  Order toEntity() {
    return Order(
      deliveryPrice: delivPriceOrd,
      transactionNumber: transNbrOrd ?? 0,
      createdAt: createdAtOrd,
      cancelComment: cancelCommentDel ?? '',
      idOrd: idOrd,
    );
  }
}

class CustomerModel {
  final String firstNameCust;
  final String lastNameCust;

  CustomerModel({required this.firstNameCust, required this.lastNameCust});

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      firstNameCust: json['firstNameCust'],
      lastNameCust: json['lastNameCust'],
    );
  }

  Customer toEntity() {
    return Customer(firstName: firstNameCust, lastName: lastNameCust);
  }
}

class BusinessModel {
  final String nameBusns;
  final String adrsBusns;
  final String imgUrlBusns;

  BusinessModel({
    required this.nameBusns,
    required this.adrsBusns,
    required this.imgUrlBusns,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      nameBusns: json['nameBusns'],
      adrsBusns: json['adrsBusns'],
      imgUrlBusns: json['imgUrlBusns'],
    );
  }

  Business toEntity() {
    return Business(name: nameBusns, address: adrsBusns, imageUrl: imgUrlBusns);
  }
}

class ProductSummaryModel {
  final String nameProd;
  final int qttyProdCart;
  final int unitProd;

  ProductSummaryModel({
    required this.unitProd,
    required this.nameProd,
    required this.qttyProdCart,
  });

  factory ProductSummaryModel.fromJson(Map<String, dynamic> json) {
    return ProductSummaryModel(
      nameProd: json['nameProd'],
      qttyProdCart: json['qttyProdCart'],
      unitProd: json['unitProd'],
    );
  }

  Product toEntity() {
    return Product(name: nameProd, quantity: qttyProdCart, unite: unitProd);
  }
}

class ProductResponseModel {
  final List<ProductSummaryModel> products;
  final double totalAmount;

  ProductResponseModel({required this.products, required this.totalAmount});

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductResponseModel(
      products:
          (json['products'] as List<dynamic>)
              .map((product) => ProductSummaryModel.fromJson(product))
              .toList(),
      totalAmount: json['totalAmount'].toDouble(),
    );
  }

  List<Product> toEntityProducts() {
    return products.map((product) => product.toEntity()).toList();
  }
}

class CompleteOrderModel {
  final OrderModel order;
  final CustomerModel customer;
  final BusinessModel business;
  final ProductResponseModel productResponse;

  CompleteOrderModel({
    required this.order,
    required this.customer,
    required this.business,
    required this.productResponse,
  });

  factory CompleteOrderModel.fromJson(Map<String, dynamic> json) {
    return CompleteOrderModel(
      order: OrderModel.fromJson(json['order']),
      customer: CustomerModel.fromJson(json['customer']),
      business: BusinessModel.fromJson(json['business']),
      productResponse: ProductResponseModel.fromJson(json['productResponse']),
    );
  }

  CompleteOrder toEntity() {
    return CompleteOrder(
      order: order.toEntity(),
      customer: customer.toEntity(),
      business: business.toEntity(),
      products: productResponse.toEntityProducts(),
      totalAmount: productResponse.totalAmount,
    );
  }
}
