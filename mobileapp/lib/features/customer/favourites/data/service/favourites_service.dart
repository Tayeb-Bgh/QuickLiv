import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/auth/presentation/providers/auth_provider.dart';
import 'package:mobileapp/features/customer/favourites/data/models/business_model.dart';

class FavouritesService {
  final Dio dio;
  final Ref ref;

  FavouritesService(this.dio, this.ref);
  
  // Récupérer la liste des business favoris d'un client
  Future<List<BusinessModel>> fetchCustomerFavourites() async {
    try {
      final secureStorage = ref.watch(secureStorageProvider);
      String? token = await secureStorage.read(key: "authToken");
      
      final response = await dio.get(
        "${await ApiConfig.getBaseUrl()}/favourites",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status! < 500; 
          },
        )
      );

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => BusinessModel.fromJson(e))
            .toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to load favourites (Status: ${response.statusCode})',
        );
      }
    } on DioException catch (e) {
      _logError("fetchCustomerFavourites", e);
      if (e.response?.statusCode == 404) {
        return []; 
      }
      rethrow;
    }
  }

  // Filtrer les favoris par type de business
  Future<List<BusinessModel>> filterFavouritesByType(String typeBusns) async {
    try {
      final secureStorage = ref.watch(secureStorageProvider);
      String? token = await secureStorage.read(key: "authToken");
      
      final response = await dio.get(
        "${await ApiConfig.getBaseUrl()}/favourites/filter/$typeBusns",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status! < 500; 
          },
        )
      );

      if (response.statusCode == 200) {
       

        return (response.data as List)
            .map((e) => BusinessModel.fromJson(e))
            .toList();

      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to filter favourites (Status: ${response.statusCode})',
        );
      }
    } on DioException catch (e) {
      _logError("filterFavouritesByType", e);
      if (e.response?.statusCode == 404) {
        return []; 
      }
      rethrow;
    }
  }

  // Ajouter un business aux favoris
  Future<bool> addFavourite(int idBusnsFav) async {
    try {
      final secureStorage = ref.watch(secureStorageProvider);
      String? token = await secureStorage.read(key: "authToken");
      
      final response = await dio.post(
        "${await ApiConfig.getBaseUrl()}/favourites/$idBusnsFav",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to add favourite (Status: ${response.statusCode})',
        );
      }
    } on DioException catch (e) {
      _logError("addFavourite", e);
      return false;
    }
  }

  // Supprimer un business des favoris
  Future<bool> deleteFavourite(int idBusnsFav) async {
    try {
      final secureStorage = ref.watch(secureStorageProvider);
      String? token = await secureStorage.read(key: "authToken");
      
      final response = await dio.delete(
        "${await ApiConfig.getBaseUrl()}/favourites/$idBusnsFav",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to remove favourite (Status: ${response.statusCode})',
        );
      }
    } on DioException catch (e) {
      _logError("removeFavourite", e);
      if (e.response?.statusCode == 404) {
        // Le favori n'existait déjà pas
        return true;
      }
      return false;
    }
  }
  
  
  void _logError(String method, DioException e) {
    print("❌ [FavouritesService.$method] Error: ${e.message}");
    if (e.response != null) {
      print("Status code: ${e.response?.statusCode}");
      print("Response data: ${e.response?.data}");
    } else if (e.error != null) {
      print("Error details: ${e.error}");
    }
  }
}