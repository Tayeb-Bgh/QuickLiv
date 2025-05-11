import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobileapp/core/config/backend_api_config.dart';
import 'package:mobileapp/features/auth/presentation/providers/auth_provider.dart';
import 'package:mobileapp/features/customer/gesProfil/DevCommercant/business/entities/trader.dart';
import 'package:mobileapp/features/customer/gesProfil/DevCommercant/business/repositories/trader_repository.dart';
import 'package:mobileapp/features/customer/gesProfil/DevCommercant/data/models/trader_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:mobileapp/features/customer/gesProfil/DevCommercant/data/service/trader_service.dart';

class TraderRepositoryImpl implements TraderRepository {
  final Dio dio;
  final WidgetRef ref;
  late final TraderService traderService;

  TraderRepositoryImpl(this.dio, this.ref) {
    traderService = TraderService(dio, ref);
  }

  @override
  Future<void> saveTrader(Trader trader) async {
    await traderService.saveTrader(trader);
  }

  @override
  Future<void> updateSubmitedClient() async {
    await traderService.updateSubmitedClient();
  }
}

