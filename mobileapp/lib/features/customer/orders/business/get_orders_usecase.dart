import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapp/features/customer/orders/business/entities/business_entity.dart';
import 'package:mobileapp/features/customer/orders/business/entities/deliverer_entity.dart';
import 'package:mobileapp/features/customer/orders/business/entities/order_entity.dart';
import 'package:mobileapp/features/customer/orders/business/entities/product_entity.dart';

List<Order> getMockOrders() {
  final business = Business(
    id: 1,
    name: 'Burger King',
    imgUrl:
        "https://res.cloudinary.com/dj6wpivpf/image/upload/v1746613506/photo_5825810712969201824_x_qyn0yv.jpg",
  );
  final deliverer = Deliverer(
    id: 1,
    firstName: 'Doussan',
    lastName: 'BENKERROU',
    phoneNumber: '0669 23 12 90',
    imgUrl:
        "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170925/samples/man-portrait.jpg",
  );

  return [
    Order(
      id: 1,
      status: 4,
      createdAt: DateTime.now(),
      totalAmount: 2500,
      priceWithReduc: null,
      deliveryPrice: 300,
      paymentMethod: true,
      business: business,
      deliverer: deliverer,
      products: [
        Product(
          id: 1,
          name: 'Double Cheeze Burger',
          price: 250,
          quantity: 1,
          unit: true,
          notice: '',
        ),
        Product(
          id: 2,
          name: 'Pizza champignon',
          price: 250,
          quantity: 1,
          unit: true,
          notice: 'Sans olive svp',
        ),
      ],
      ratingBusns: 5,
      ratingDel: 3,
      delivererLocation: LatLng(0, 0),
      customerLocation: LatLng(0, 0),
    ),
    Order(
      id: 2,
      status: 0,
      createdAt: DateTime.now(),
      totalAmount: 2500,
      priceWithReduc: 0,
      deliveryPrice: 300,
      paymentMethod: false,
      business: business,
      deliverer: null,
      products: [
        Product(
          id: 1,
          name: 'Tacos 3 viandes',
          price: 250,
          quantity: 1,
          unit: true,
          notice: '',
        ),
        Product(
          id: 2,
          name: 'Chapatti thon',
          price: 250,
          quantity: 1,
          unit: true,
          notice: 'Pas de salade svp',
        ),
      ],
      ratingBusns: null,
      ratingDel: null,
      delivererLocation: null,
      customerLocation: LatLng(0, 0),
    ),
    // 3 autres exemples similaires avec status: 1, 2, 3
    Order(
      id: 3,
      status: 1,
      createdAt: DateTime.now(),
      totalAmount: 2500,
      deliveryPrice: 300,
      priceWithReduc: null,
      paymentMethod: true,
      business: business,
      deliverer: deliverer,
      products: [
        Product(
          id: 1,
          name: 'Pizza napolitaine',
          price: 250,
          quantity: 1,
          unit: true,
          notice: '',
        ),
      ],
      ratingBusns: null,
      ratingDel: null,
      delivererLocation: LatLng(0, 0),
      customerLocation: LatLng(0, 0),
    ),
  ];
}
