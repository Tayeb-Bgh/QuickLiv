import 'package:dio/dio.dart';
import 'package:mobileapp/features/auth/business/usecases/check_phone_usecase.dart';
import 'package:mobileapp/features/auth/business/usecases/verify_otp_usecase.dart';
import 'package:mobileapp/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mobileapp/features/auth/data/service/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider((ref) => Dio());
final authServiceProvider = Provider((ref) => AuthService(ref.watch(dioProvider)));
final authRepositoryProvider = Provider((ref) => AuthRepositoryImpl(ref.watch(authServiceProvider)));

final checkPhoneUseCaseProvider = Provider((ref) => CheckPhoneUseCase(ref.watch(authRepositoryProvider)));
final verifyOtpUseCaseProvider =  Provider((ref) => VerifyOtpUseCase(ref.watch(authRepositoryProvider))); 
