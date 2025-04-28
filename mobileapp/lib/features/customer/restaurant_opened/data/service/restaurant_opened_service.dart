import 'package:dio/dio.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/customer/restaurant_opened/data/models/product_model.dart';

class RestaurantOpenedService {
  final Dio dio;

  RestaurantOpenedService(this.dio);

  Future<List<String>> fetchCategories(int restaurantId) async {
    String baseUrl = await ApiConfig.getBaseUrl();
    final response = await dio.get(
      '$baseUrl/restaurant-opened/$restaurantId/categories',
    );

    final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(
      response.data,
    );

    final List<String> categories =
        data.map((item) => item['secondCategoryProd'] as String).toList();

    return categories;
  }

  /* Future<List<Product>> fetchProducts() async {
    // Simule un délai de chargement
    await Future.delayed(Duration(seconds: 2));

    // Exemple de produits
    return [
      Product(
        id: 1,
        name: 'Pizza Margherita',
        desc:'Delicious cheese and tomato pizza with thon au fromage a la sauce',
        category: 'Pizzas',
        imgUrl: 'https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg',
        price: 500,
        priceWithReduc: null
      ),
      Product(
        id: 2,
        name: 'Burger Classic',
        desc: 'Classic beef burger with lettuce and tomato',
        category: 'Burgers',
        imgUrl: 'https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg',
        price: 600,
        priceWithReduc: 500
      ),
      Product(
        id: 3,
        name: 'Tiramisu',
        desc: 'Classic Italian dessert with coffee and mascarpone',
        category: 'Desserts',
        imgUrl: 'https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg',
        price: 900,
        priceWithReduc: null
      ),
      Product(
        id: 4,
        name: 'Caesar Salad',
        desc: 'Fresh salad with chicken, croutons, and Caesar dressing',
        category: 'Salads',
        imgUrl: 'https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg',
        price: 400,
        priceWithReduc: null
      ),
      Product(
        id: 5,
        name: 'Spaghetti Carbonara',
        desc: 'Pasta with creamy sauce, bacon, and cheese',
        category: 'Pasta',
        imgUrl: 'https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg',
        price: 700,
        priceWithReduc: null
      ),
      Product(
        id: 6,
        name: 'Grilled Chicken',
        desc: 'Juicy grilled chicken with herbs and spices',
        category: 'Grillades',
        imgUrl: 'https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg',
        price: 800,
        priceWithReduc: null
      ),
      Product(
        id: 7,
        name: 'Chocolate Cake',
        desc: 'Rich chocolate cake with ganache frosting',
        category: 'Desserts',
        imgUrl: 'https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg',
        price: 1000,
        priceWithReduc: null
      ),
      Product(
        id: 8,
        name: 'Greek Salad',
        desc: 'Fresh salad with feta cheese and olives',
        category: 'Salads',
        imgUrl: 'https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg',
        price: 450,
        priceWithReduc: null
      ),
      Product(
        id: 9,
        name: 'Lasagna',
        desc: 'Layered pasta with meat and cheese',
        category: 'Pasta',
        imgUrl: 'https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg',
        price: 750,
        priceWithReduc: null
      ),
      Product(
        id: 10,
        name: 'BBQ Ribs',
        desc: 'Tender ribs with barbecue sauce',
        category: 'Grillades',
        imgUrl: 'https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg',
        price: 1200,
        priceWithReduc: null
      ),
      Product(
        id: 11,
        name: 'Fruit Salad',
        desc: 'Fresh seasonal fruits',
        category: 'Salads',
        imgUrl: 'https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg',
        price: 350,
        priceWithReduc: null
      ),
      Product(
        id: 12,
        name: 'Pasta Primavera',
        desc: 'Pasta with fresh vegetables and olive oil',
        category: 'Pasta',
        imgUrl: 'https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg',
        price: 650,
        priceWithReduc: null
      ),
    ];
  }
   */
  Future<List<ProductModel>> fetchProducts(int restaurantId) async {
    String baseUrl = await ApiConfig.getBaseUrl();
    final response = await dio.get(
      '$baseUrl/restaurant-opened/$restaurantId/products',
    );

    final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(
      response.data,
    );
    print("data repondu : ${data[0]}");
    final List<ProductModel> products = data.map((item) => ProductModel.fromJson(item)).toList();
    print(products[0].toStringg());
    return products;
  }
}
