// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mobileapp/features/customer/coupons_store/Data/repositories/clientPoint_repositorieImp.dart';
// import 'package:mobileapp/features/customer/coupons_store/Data/services/clientPoint_service.dart';
// import 'package:mobileapp/features/customer/coupons_store/business/repositories/clientPoint_repositorie.dart';
// import 'package:mobileapp/features/customer/coupons_store/business/usercases/clientPoint_usercase.dart';

// class PointNotifier extends StateNotifier<AsyncValue<int>> {
//   final GetCustomerPointsUseCase _getCustomerPointsUseCase;
//   final UpdateCustomerPointsUseCase _updateCustomerPointsUseCase;

//   PointNotifier(
//     this._getCustomerPointsUseCase,
//     this._updateCustomerPointsUseCase,
//   ) : super(const AsyncValue.loading()) {
//     _loadPoints(); // appel ici
//   }

//   Future<void> _loadPoints() async {
//     try {
//       final pointsEntity = await _getCustomerPointsUseCase();
//       state = AsyncValue.data(pointsEntity.customerPoints);
//     } catch (e, stackTrace) {
//       state = AsyncValue.error(e, stackTrace);
//       print('Failed to load customer points: $e');
//     }
//   }

//   Future<void> updatePoints(int newPoints) async {
//     try {
//       // Optimistic update
//       if (state is AsyncData) {
//         final currentPoints = (state as AsyncData<int>).value;
//         state = AsyncValue.data(newPoints);
//       }

//       // API call
//       await _updateCustomerPointsUseCase(newPoints);
//     } catch (e, stackTrace) {
//       state = AsyncValue.error(e, stackTrace);
//       print('Failed to update customer points: $e');
//       // Retry loading points from server on failure
//       _loadPoints();
//     }
//   }

//   Future<void> subtractPoints(int pointsToSubtract) async {
//     if (state is AsyncData) {
//       final currentPoints = (state as AsyncData<int>).value;
//       if (currentPoints >= pointsToSubtract) {
//         await updatePoints(currentPoints - pointsToSubtract);
//       }
//     }
//   }
// }

// // Fournisseur pour l'usecase
// final getCustomerPointsUseCaseProvider = Provider<GetCustomerPointsUseCase>((
//   ref,
// ) {
//   final repository = ref.watch(customerPointsRepositoryProvider);
//   return GetCustomerPointsUseCase(repository);
// });

// // Fournisseur pour l'usecase de mise à jour
// final updateCustomerPointsUseCaseProvider =
//     Provider<UpdateCustomerPointsUseCase>((ref) {
//       final repository = ref.watch(customerPointsRepositoryProvider);
//       return UpdateCustomerPointsUseCase(repository);
//     });

// // Fournisseur pour le repository
// final customerPointsRepositoryProvider = Provider<CustomerPointsRepository>((
//   ref,
// ) {
//   final service = ref.watch(customerPointServiceProvider);
//   return CustomerPointRepositoryImpl(service);
// });

// // Fournisseur pour le service
// final customerPointServiceProvider = Provider<CustomerPointService>((ref) {
//   final dio = ref.watch(dioProvider);
//   return CustomerPointService(dio);
// });

// // Fournisseur pour Dio
// final dioProvider = Provider<Dio>((ref) {
//   return Dio();
// });

// // Provider d'état pour les points du client
// final pointProvider = StateNotifierProvider<PointNotifier, AsyncValue<int>>((
//   ref,
// ) {
//   final getCustomerPointsUseCase = ref.watch(getCustomerPointsUseCaseProvider);
//   final updateCustomerPointsUseCase = ref.watch(
//     updateCustomerPointsUseCaseProvider,
//   );
//   return PointNotifier(getCustomerPointsUseCase, updateCustomerPointsUseCase);
// });







// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mobileapp/features/customer/coupons_store/Data/repositories/clientPoint_repositorieImp.dart';
// import 'package:mobileapp/features/customer/coupons_store/Data/services/clientPoint_service.dart';
// import 'package:mobileapp/features/customer/coupons_store/business/repositories/clientPoint_repositorie.dart';
// import 'package:mobileapp/features/customer/coupons_store/business/usercases/clientPoint_usercase.dart';

// class PointNotifier extends StateNotifier<AsyncValue<int>> {
//   final GetCustomerPointsUseCase _getCustomerPointsUseCase;
//   final UpdateCustomerPointsUseCase _updateCustomerPointsUseCase;

//   PointNotifier(
//     this._getCustomerPointsUseCase,
//     this._updateCustomerPointsUseCase,
//   ) : super(const AsyncValue.loading()) {
//     _loadPoints();
//   }

//   Future<void> _loadPoints() async {
//     try {
//       // Indiquer que le chargement est en cours
//       state = const AsyncValue.loading();

//       final pointsEntity = await _getCustomerPointsUseCase();

//       // Vérifier si l'état a été modifié entre-temps
//       if (mounted) {
//         state = AsyncValue.data(pointsEntity.customerPoints);
//       }
//     } catch (e, stackTrace) {
//       // Enregistrer l'erreur et mettre à jour l'état
//       print('Failed to load customer points: $e');
//       if (mounted) {
//         state = AsyncValue.error(e, stackTrace);
//       }
//     }
//   }

//   Future<void> updatePoints(int newPoints) async {
//     // Sauvegarde de l'ancien état
//     final previousState = state;
//     try {
//       // Optimistic update
//       if (state is AsyncData) {
//         state = AsyncValue.data(newPoints);
//       }

//       // API call
//       await _updateCustomerPointsUseCase(newPoints);
//     } catch (e, stackTrace) {
//       print('Failed to update customer points: $e');

//       // Restaurer l'ancien état en cas d'erreur
//       if (previousState is AsyncData) {
//         state = previousState;
//       } else {
//         state = AsyncValue.error(e, stackTrace);
//       }

//       // Recharger les points depuis le serveur
//       _loadPoints();

//       // Propager l'erreur pour la gestion par l'appelant
//       rethrow;
//     }
//   }

//   Future<bool> subtractPoints(int pointsToSubtract) async {
//     if (state is AsyncData) {
//       final currentPoints = (state as AsyncData<int>).value;

//       if (currentPoints >= pointsToSubtract) {
//         try {
//           await updatePoints(currentPoints - pointsToSubtract);
//           return true;
//         } catch (e) {
//           // L'erreur est déjà gérée dans updatePoints
//           return false;
//         }
//       } else {
//         throw Exception('Points insuffisants pour cette opération');
//       }
//     }
//     return false;
//   }

//   // Ajouter des points (utilisé après un achat ou une recommandation)
//   Future<bool> addPoints(int pointsToAdd) async {
//     if (state is AsyncData) {
//       final currentPoints = (state as AsyncData<int>).value;
//       try {
//         await updatePoints(currentPoints + pointsToAdd);
//         return true;
//       } catch (e) {
//         return false;
//       }
//     }
//     return false;
//   }

//   // Rafraîchir les points manuellement
//   Future<void> refreshPoints() async {
//     await _loadPoints();
//   }
// }

// // Les providers restent identiques
// final getCustomerPointsUseCaseProvider = Provider<GetCustomerPointsUseCase>((
//   ref,
// ) {
//   final repository = ref.watch(customerPointsRepositoryProvider);
//   return GetCustomerPointsUseCase(repository);
// });

// final updateCustomerPointsUseCaseProvider =
//     Provider<UpdateCustomerPointsUseCase>((ref) {
//       final repository = ref.watch(customerPointsRepositoryProvider);
//       return UpdateCustomerPointsUseCase(repository);
//     });

// final customerPointsRepositoryProvider = Provider<CustomerPointsRepository>((
//   ref,
// ) {
//   final service = ref.watch(customerPointServiceProvider);
//   return CustomerPointRepositoryImpl(service);
// });

// final customerPointServiceProvider = Provider<CustomerPointService>((ref) {
//   final dio = ref.watch(dioProvider);
//   return CustomerPointService(dio);
// });

// final dioProvider = Provider<Dio>((ref) {
//   return Dio();
// });

// final pointProvider = StateNotifierProvider<PointNotifier, AsyncValue<int>>((
//   ref,
// ) {
//   final getCustomerPointsUseCase = ref.watch(getCustomerPointsUseCaseProvider);
//   final updateCustomerPointsUseCase = ref.watch(
//     updateCustomerPointsUseCaseProvider,
//   );
//   return PointNotifier(getCustomerPointsUseCase, updateCustomerPointsUseCase);
// });











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
        // final currentPoints = (state as AsyncData<int>).value;
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
        await updatePoints(currentPoints - pointsToSubtract);
      }
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