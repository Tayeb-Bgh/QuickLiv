import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/customer/restaurant_opened/business/usecases/get_categories_usecase.dart';
import 'package:mobileapp/features/customer/restaurant_opened/data/service/restaurant_opened_service.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final categoryServiceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return RestaurantOpenedService(dio);
});

final getCategoriesUseCaseProvider = Provider((ref) {
  final service = ref.watch(categoryServiceProvider);
  return GetCategoriesUseCase(service);
});

final restaurantCategoriesProvider =
    FutureProvider.family<List<String>, int>((ref, restaurantId) async {
  final useCase = ref.watch(getCategoriesUseCaseProvider);
  return useCase(restaurantId);
});
