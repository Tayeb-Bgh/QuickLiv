// entities.dart - Définition des entités métier
class Order {
  final double deliveryPrice;
  final int transactionNumber;
  final DateTime createdAt;
  final String cancelComment;
  final int idOrd;

  Order({
    required this.deliveryPrice,
    required this.transactionNumber,
    required this.createdAt,
    required this.cancelComment,
    required this.idOrd
  });
}

class Customer {
  final String firstName;
  final String lastName;

  Customer({required this.firstName, required this.lastName});
}

class Business {
  final String name;
  final String address;
  final String imageUrl;

  Business({required this.name, required this.address, required this.imageUrl});
}

class Product {
  final String name;
  final int quantity;

  Product({required this.name, required this.quantity});
}

class CompleteOrder {
  final Order order;
  final Customer customer;
  final Business business;
  final List<Product> products;
  final double totalAmount; 

  CompleteOrder({
    required this.order,
    required this.customer,
    required this.business,
    required this.products,
    required this.totalAmount,
  });
}
