import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/customer/restaurant_opened/business/entities/product_entity.dart';
import 'package:mobileapp/features/customer/restaurant_opened/business/repositories/restaurant_opened.dart';
import 'package:mobileapp/features/customer/restaurant_opened/business/usecases/get_categories_usecase.dart';
import 'package:mobileapp/features/customer/restaurant_opened/business/usecases/get_products_usecase.dart';
import 'package:mobileapp/features/customer/restaurant_opened/data/repositories/restaurant_opened_repository_impl.dart';
import 'package:mobileapp/features/customer/restaurant_opened/data/service/restaurant_opened_service.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final restaurantOpenedServiceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return RestaurantOpenedService(dio);
});

final getCategoriesUseCaseProvider = Provider((ref) {
  final service = ref.watch(restaurantOpenedServiceProvider);
  return GetCategoriesUseCase(service);
});

final restaurantCategoriesProvider = FutureProvider.family<List<String>, int>((
  ref,
  restaurantId,
) async {
  final useCase = ref.watch(getCategoriesUseCaseProvider);
  return useCase(restaurantId);
});





final restaurantOpenedRepositoryProvider = Provider<RestaurantOpenedRepository>((ref){
    return RestaurantOpenedRepositoryImpl(
      ref.watch(restaurantOpenedServiceProvider),
    );
  },
);

final getProductsUseCaseProvider = Provider((ref) {
  final repository = ref.watch(restaurantOpenedRepositoryProvider);
  return GetProductsUsecase(repository);
});

// FutureProvider qui charge les produits du restaurant
final restaurantProductsProvider = FutureProvider.family<List<Product>, int>((
  ref,
  restaurantId,
) async {
  return ref.watch(getProductsUseCaseProvider).call(restaurantId);
});

final selectedCategoryProvider = StateProvider<String?>((ref) => null);
