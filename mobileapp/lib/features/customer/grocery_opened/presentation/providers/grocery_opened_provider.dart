import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/grocery_opened/business/entities/product_entity.dart';
import 'package:mobileapp/features/customer/grocery_opened/business/usecases/filter_products_by_category.dart';
import 'package:mobileapp/features/customer/grocery_opened/business/usecases/get_categories.dart';
import 'package:mobileapp/features/customer/grocery_opened/business/usecases/get_products.dart';
import 'package:mobileapp/features/customer/grocery_opened/business/usecases/get_second_categories.dart';
import 'package:mobileapp/features/customer/grocery_opened/business/usecases/search_products.dart';
import 'package:mobileapp/features/customer/grocery_opened/data/repositories/grocery_opened_repository_impl.dart';
import 'package:mobileapp/features/customer/grocery_opened/data/services/grocery_opened_service.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final groceryOpenedServiceProvider = Provider<GroceryOpenedService>((ref) {
  return GroceryOpenedService(dio: ref.watch(dioProvider));
});

final groceryOpenedRepositoryProvider = Provider<GroceryOpenedRepositoryImpl>((
  ref,
) {
  return GroceryOpenedRepositoryImpl(
    groceryOpenedService: ref.watch(groceryOpenedServiceProvider),
  );
});

//* current grocery provider

final selectedGroceryProvider = StateProvider<Grocery?>((ref) {
  return null;
});

// * selected cateogries chboxes
final selectedCategoriesProvider = StateProvider<List<String>>((ref) => []);

final selectedSecondCategoriesProvider = StateProvider<List<String>>(
  (ref) => [],
);

final selectedSecondCategoryProvider = StateProvider<String?>((ref) => null);

//* all grocery categories
final getCategoriesProvider = Provider<GetCategories>((ref) {
  return GetCategories(
    groceryOpenedRepository: ref.watch(groceryOpenedRepositoryProvider),
  );
});

final categoriesProvider = FutureProvider<List<String>>((ref) async {
  final Grocery? grocery = ref.watch(selectedGroceryProvider);

  print(
    "[DEBUG] in categories provider selected grocery: ${grocery?.id} ${grocery?.name}",
  );

  if (grocery == null) return [];

  return await ref.watch(getCategoriesProvider).call(grocery.id);
});

//* get second ctagories of a categoryprovider
final getSecondCategoriesProvider = Provider<GetSecondCategories>((ref) {
  return GetSecondCategories(
    groceryOpenedRepository: ref.watch(groceryOpenedRepositoryProvider),
  );
});

final secondCateogriesMapProvider = FutureProvider<Map<String, List<String>>>((
  ref,
) async {
  final Grocery? grocery = ref.watch(selectedGroceryProvider);

  print(
    "[DEBUG] in second categories map provider selected grocery: ${grocery?.id} ${grocery?.name}",
  );
  if (grocery == null) return {};

  List<String> categories = await ref.watch(categoriesProvider.future);
  Map<String, List<String>> secondCategoriesMap = {};

  for (final String category in categories) {
    final List<String> secondCategoriesList = await ref
        .watch(getSecondCategoriesProvider)
        .call(grocery.id, category);

    secondCategoriesMap[category] = secondCategoriesList;
  }

  print("[DEBUG] second categories map:");
  for (final key in secondCategoriesMap.keys)
    print("$key : ${secondCategoriesMap[key]}");

  return secondCategoriesMap;
});

final secondCategoriesProvider = FutureProvider<List<String>>((ref) async {
  final Grocery? grocery = ref.watch(selectedGroceryProvider);

  if (grocery == null) return [];

  List<String> categories = await ref.watch(categoriesProvider.future);
  List<String> secondCategories = [];

  for (final String category in categories) {
    final List<String> secondCategoriesList = await ref
        .watch(getSecondCategoriesProvider)
        .call(grocery.id, category);

    for (String cat in secondCategoriesList) {
      secondCategories.add(cat);
    }
  }

  return secondCategories;
});

//* all grocery products EN VRAC

final getGroceryProductsProvider = Provider<GetProducts>(
  (ref) => GetProducts(
    groceryOpenedRepositoryImpl: ref.watch(groceryOpenedRepositoryProvider),
  ),
);

final groceryProductsProvider = FutureProvider<List<Product>>((ref) async {
  final Grocery? grocery = ref.watch(selectedGroceryProvider);

  print(
    "[DEBUG] in second grocery's products provider selected grocery: ${grocery?.id} ${grocery?.name}",
  );

  if (grocery == null) return [];

  final List<Product> products = await ref
      .watch(getGroceryProductsProvider)
      .call(ref.watch(selectedGroceryProvider)!.id);

  print("[DEBUG] in second grocery's products provider: $products");

  return products;
});

final filterProductsByCategoryProvider = Provider<FilterProductsByCategory>(
  (ref) => FilterProductsByCategory(),
);

final searchControllerProvider = Provider.autoDispose<TextEditingController>((
  ref,
) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final searchTextProvider = StateProvider<String>((ref) => '');

final searchProductsProvider = Provider<SearchProducts>((ref) {
  return SearchProducts();
});
