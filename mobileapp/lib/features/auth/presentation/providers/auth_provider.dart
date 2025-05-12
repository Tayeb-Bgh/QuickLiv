import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobileapp/features/auth/business/usecases/check_phone_usecase.dart';
import 'package:mobileapp/features/auth/business/usecases/get_customer_info_usecase.dart';
import 'package:mobileapp/features/auth/business/usecases/register_custumor_usecase.dart';
import 'package:mobileapp/features/auth/business/usecases/verify_otp_usecase.dart';
import 'package:mobileapp/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mobileapp/features/auth/data/service/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Providers
final secureStorageProvider = Provider((ref) => const FlutterSecureStorage());
final dioProvider = Provider((ref) => Dio());

final authRepositoryProvider = Provider(
  (ref) => AuthRepositoryImpl(ref.watch(dioProvider), ref),
);

final checkPhoneUseCaseProvider = Provider(
  (ref) => CheckPhoneUseCase(ref.watch(authRepositoryProvider)),
);

final verifyOtpUseCaseProvider = Provider(
  (ref) => VerifyOtpUseCase(ref.watch(authRepositoryProvider)),
);

final getCustomerInfoUseCaseProvider = Provider(
  (ref) => GetCustomerInfoUseCase(ref.watch(authRepositoryProvider)),
);

final registerCustomerInfoUseCaseProvider = Provider(
  (ref) => RegisterUser(ref.watch(authRepositoryProvider)),
);

final jwtTokenProvider = FutureProvider<String?>((ref) async {
  final secureStorage = ref.watch(secureStorageProvider);
  return await secureStorage.read(key: 'authToken');
});

// Form data notifier
class FormDataNotifier extends StateNotifier<Map<String, String>> {
  FormDataNotifier() : super({});
    void updateField(String field, String value) {
    state = {...state, field: value};
  }
}

// Form data provider
final formDataProvider = StateNotifierProvider<FormDataNotifier, Map<String, String>>((ref) {
  return FormDataNotifier();
});