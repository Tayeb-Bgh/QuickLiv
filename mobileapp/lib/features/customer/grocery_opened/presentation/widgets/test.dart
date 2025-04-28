import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/customer/grocery_opened/presentation/widgets/products_list_view.dart';
import 'package:mobileapp/features/customer/grocery_opened/business/entities/product_entity.dart';

class Test extends ConsumerWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);
    final appBarBgColor = kPrimaryRed;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final additionalInformationsWidth = width * 0.25;
    final mainInformationsWidth = width * 0.6;
    final topBarHeight = height * 0.23;

    return Column(
      children: [
        ProductsListView(
          title: "Our Pizzas",
          products: [
            Product(
              idProd: 1,
              idBusns: 101,
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 900,
              description: "caca",
              name: "Pizza margharita",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
            Product(
              idProd: 2,
              idBusns: 101,
              name: "Pizza Pepperoni",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 1000,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
            Product(
              idProd: 3,
              idBusns: 101,
              name: "Pizza 4 Fromages",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 1100,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
            Product(
              idProd: 4,
              idBusns: 101,
              name: "Pizza Végétarienne",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 950,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
          ],
        ),
        ProductsListView(
          title: "Our Pizzas",
          products: [
            Product(
              idProd: 1,
              idBusns: 101,
              name: "Pizza Margherita",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 900,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
            Product(
              idProd: 2,
              idBusns: 101,
              name: "Pizza Pepperoni",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 1000,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
            Product(
              idProd: 3,
              idBusns: 101,
              name: "Pizza 4 Fromages",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 1100,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
            Product(
              idProd: 4,
              idBusns: 101,
              name: "Pizza Végétarienne",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 950,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
          ],
        ),
        ProductsListView(
          title: "Our Pizzas",
          products: [
            Product(
              idProd: 1,
              idBusns: 101,
              name: "Pizza Margherita",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 900,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
            Product(
              idProd: 2,
              idBusns: 101,
              name: "Pizza Pepperoni",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 1000,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
            Product(
              idProd: 3,
              idBusns: 101,
              name: "Pizza 4 Fromages",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 1100,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
            Product(
              idProd: 4,
              idBusns: 101,
              name: "Pizza Végétarienne",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 950,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
          ],
        ),
        ProductsListView(
          title: "Our Pizzas",
          products: [
            Product(
              idProd: 1,
              idBusns: 101,
              name: "Pizza Margherita",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 900,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
            Product(
              idProd: 2,
              idBusns: 101,
              name: "Pizza Pepperoni",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 1000,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
            Product(
              idProd: 3,
              idBusns: 101,
              name: "Pizza 4 Fromages",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 1100,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
            Product(
              idProd: 4,
              idBusns: 101,
              name: "Pizza Végétarienne",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 950,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
          ],
        ),
        ProductsListView(
          title: "Our Pizzas",
          products: [
            Product(
              idProd: 1,
              idBusns: 101,
              name: "Pizza Margherita",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 900,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
            Product(
              idProd: 2,
              idBusns: 101,
              name: "Pizza Pepperoni",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 1000,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
            Product(
              idProd: 3,
              idBusns: 101,
              name: "Pizza 4 Fromages",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 1100,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
            Product(
              idProd: 4,
              idBusns: 101,
              name: "Pizza Végétarienne",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 950,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
          ],
        ),
        ProductsListView(
          title: "Our Pizzas",
          products: [
            Product(
              idProd: 1,
              idBusns: 101,
              name: "Pizza Margherita",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 900,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
            Product(
              idProd: 2,
              idBusns: 101,
              name: "Pizza Pepperoni",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 1000,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
            Product(
              idProd: 3,
              idBusns: 101,
              name: "Pizza 4 Fromages",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 1100,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
            Product(
              idProd: 4,
              idBusns: 101,
              name: "Pizza Végétarienne",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 950,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
          ],
        ),
        ProductsListView(
          title: "Our Pizzas",
          products: [
            Product(
              idProd: 1,
              idBusns: 101,
              name: "Pizza Margherita",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 900,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
            Product(
              idProd: 2,
              idBusns: 101,
              name: "Pizza Pepperoni",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 1000,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
            Product(
              idProd: 3,
              idBusns: 101,
              name: "Pizza 4 Fromages",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 1100,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
            Product(
              idProd: 4,
              idBusns: 101,
              name: "Pizza Végétarienne",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 950,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
          ],
        ),
        ProductsListView(
          title: "Our Pizzas",
          products: [
            Product(
              idProd: 1,
              idBusns: 101,
              name: "Pizza Margherita",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 900,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
            Product(
              idProd: 2,
              idBusns: 101,
              name: "Pizza Pepperoni",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 1000,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
            Product(
              idProd: 3,
              idBusns: 101,
              name: "Pizza 4 Fromages",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 1100,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
            Product(
              idProd: 4,
              idBusns: 101,
              name: "Pizza Végétarienne",
              imgUrl:
                  "https://res.cloudinary.com/dj6wpivpf/image/upload/v1743170927/samples/dessert-on-a-plate.jpg",
              price: 950,
              description: "caca",
              category: "Meilleure pizza dz",
              secondCategory: "pizza carée",
              unit: false,
            ),
          ],
        ),
      ],
    );
  }
}
