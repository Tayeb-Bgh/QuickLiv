import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobileapp/core/hive_object/customer_hive_object.dart';
import 'package:mobileapp/core/hive_object/deliverer_hive_object.dart';
import 'package:mobileapp/core/hive_object/vehicle_hive_object.dart';
import 'package:mobileapp/features/customer/skeleton/presentation/customer_skeleton.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top],
  );
  await Hive.initFlutter();

  Hive.registerAdapter(CustomerHiveObjectAdapter());
  Hive.registerAdapter(VehicleHiveObjectAdapter());
  Hive.registerAdapter(DelivererHiveObjectAdapter());

  runApp(ProviderScope(child: MyApp()));
}

@override
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,

      home: CustomerSkeleton(),
    );
  }
}
