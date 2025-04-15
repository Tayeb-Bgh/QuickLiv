import 'package:dio/dio.dart';
import 'package:mobileapp/features/auth/business/usecases/get.dart';
import 'package:mobileapp/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mobileapp/features/auth/data/service/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider((ref) => Dio());
final authServiceProvider = Provider((ref) => AuthService(ref.watch(dioProvider)));
final authRepositoryProvider = Provider((ref) => AuthRepositoryImpl(ref.watch(authServiceProvider)));
final checkPhoneUseCaseProvider = Provider((ref) => CheckPhoneUseCase(ref.watch(authRepositoryProvider)));
