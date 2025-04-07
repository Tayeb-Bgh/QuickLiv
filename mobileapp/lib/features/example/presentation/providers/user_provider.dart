
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/home/business/entities/user_entity.dart';
import 'package:mobileapp/features/home/business/usecases/get_users.dart';
import 'package:mobileapp/features/home/data/repositories_implement/user_repository_impl.dart';
import 'package:mobileapp/features/home/data/services/user_service.dart';
import 'package:dio/dio.dart';

final dioProvider = Provider((ref) => Dio());

final userServiceProvider = Provider((ref) => UserService(ref.watch(dioProvider)));

final userRepositoryProvider = Provider((ref) =>
    UserRepositoryImpl(ref.watch(userServiceProvider)));

final getUsersProvider = Provider((ref) =>
    GetUsers(ref.watch(userRepositoryProvider)));

final usersFutureProvider = FutureProvider<List<UserEntity>>((ref) async {
  return await ref.watch(getUsersProvider).call();
});
