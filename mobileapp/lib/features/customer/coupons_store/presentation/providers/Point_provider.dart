
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/customer/coupons_store/Data/repositories/clientPoint_repositorieImp.dart';
import 'package:mobileapp/features/customer/coupons_store/Data/services/clientPoint_service.dart';
import 'package:mobileapp/features/customer/coupons_store/Data/services/hive_service.dart';
import 'package:mobileapp/features/customer/coupons_store/business/repositories/clientPoint_repositorie.dart';
import 'package:mobileapp/features/customer/coupons_store/business/usercases/clientPoint_usercase.dart';

class PointNotifier extends StateNotifier<AsyncValue<int>> {
  final GetCustomerPointsUseCase _getCustomerPointsUseCase;
  final UpdateCustomerPointsUseCase _updateCustomerPointsUseCase;

  PointNotifier(
    this._getCustomerPointsUseCase,
    this._updateCustomerPointsUseCase,
  ) : super(const AsyncValue.loading()) {
    _loadPoints(); // appel ici
  }

  Future<void> _loadPoints() async {
    try {
      // D'abord, essayer de charger depuis Hive
      final cachedPoints = HiveStorageService.getPoints();
      if (cachedPoints != null) {
        state = AsyncValue.data(cachedPoints);
      }

      // Ensuite, charger depuis l'API
      final pointsEntity = await _getCustomerPointsUseCase();
      final newPoints = pointsEntity.customerPoints;

      // Mettre à jour Hive et l'état
      await HiveStorageService.savePoints(newPoints);
      state = AsyncValue.data(newPoints);
    } catch (e, stackTrace) {
      // En cas d'erreur API, si on a des données en cache, on les garde
      if (state is! AsyncData) {
        state = AsyncValue.error(e, stackTrace);
      }
      print('Failed to load customer points: $e');
    }
  }

  Future<void> updatePoints(int newPoints) async {
    try {
      // Optimistic update
      if (state is AsyncData) {
        state = AsyncValue.data(newPoints);
      }

      // API call
      await _updateCustomerPointsUseCase(newPoints);

      // Mise à jour dans Hive
      await HiveStorageService.savePoints(newPoints);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      print('Failed to update customer points: $e');
      // Retry loading points from server on failure
      _loadPoints();
    }
  }

  Future<void> subtractPoints(int pointsToSubtract) async {
    if (state is AsyncData) {
      final currentPoints = (state as AsyncData<int>).value;
      if (currentPoints >= pointsToSubtract) {
        try {
          // Mise à jour optimiste de l'état local
          state = AsyncValue.data(currentPoints - pointsToSubtract);

          // API call
          await _updateCustomerPointsUseCase(currentPoints - pointsToSubtract);

          // Mise à jour dans Hive
          await HiveStorageService.savePoints(currentPoints - pointsToSubtract);
        } catch (e) {
          // Restaurer l'ancien état en cas d'erreur
          state = AsyncValue.data(currentPoints);
          throw Exception('Erreur lors de la soustraction de points: $e');
        }
      } else {
        throw Exception('Points insuffisants pour cette opération');
      }
    } else {
      throw Exception('État des points non disponible');
    }
  }

  // Méthode pour forcer un rafraîchissement des points depuis l'API
  Future<void> refreshPoints() async {
    await _loadPoints();
  }
}

// Les providers restent identiques
final getCustomerPointsUseCaseProvider = Provider<GetCustomerPointsUseCase>((
  ref,
) {
  final repository = ref.watch(customerPointsRepositoryProvider);
  return GetCustomerPointsUseCase(repository);
});

final updateCustomerPointsUseCaseProvider =
    Provider<UpdateCustomerPointsUseCase>((ref) {
      final repository = ref.watch(customerPointsRepositoryProvider);
      return UpdateCustomerPointsUseCase(repository);
    });

final customerPointsRepositoryProvider = Provider<CustomerPointsRepository>((
  ref,
) {
  final service = ref.watch(customerPointServiceProvider);
  return CustomerPointRepositoryImpl(service);
});

final customerPointServiceProvider = Provider<CustomerPointService>((ref) {
  final dio = ref.watch(dioProvider);
  return CustomerPointService(dio);
});

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final pointProvider = StateNotifierProvider<PointNotifier, AsyncValue<int>>((
  ref,
) {
  final getCustomerPointsUseCase = ref.watch(getCustomerPointsUseCaseProvider);
  final updateCustomerPointsUseCase = ref.watch(
    updateCustomerPointsUseCaseProvider,
  );
  return PointNotifier(getCustomerPointsUseCase, updateCustomerPointsUseCase);
});
