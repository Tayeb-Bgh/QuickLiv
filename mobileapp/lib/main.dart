import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/customer/coupons_store/Data/services/hive_service.dart';
import 'package:mobileapp/features/customer/skeleton/presentation/skeleton.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveStorageService.init();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top],
  );
  runApp(ProviderScope(child: MyApp()));
}
@override
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Skeleton(),
    );
  }
}
