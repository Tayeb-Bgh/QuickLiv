class Product {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final bool unit;
  final String notice;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.unit,
    required this.notice,
  });

  @override
  String toString() {
    return 'Product{id: $id, name: $name, price: $price, quantity: $quantity, unit: $unit, notice: $notice}';
  }
}
