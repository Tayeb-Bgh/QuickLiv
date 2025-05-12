import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobileapp/core/hive_object/customer_hive_object.dart';
import 'package:mobileapp/core/hive_object/deliverer_hive_object.dart';
import 'package:mobileapp/core/hive_object/vehicle_hive_object.dart';
import 'package:mobileapp/features/customer/cart_popup/data/models/product_hive_object.dart';
import 'package:mobileapp/features/customer/home/presentation/pages/home_page.dart';
import 'package:mobileapp/features/customer/skeleton/presentation/customer_skeleton.dart';
import 'package:mobileapp/features/deliverer/skeleton/presentation/deliverer_skeleton.dart';
import 'features/customer/cart_popup/data/models/cart_hive_object.dart';

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
  Hive.registerAdapter(CartAdapter());
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<CustomerHiveObject>('customerBox');
  await Hive.openBox<DelivererHiveObject>('delivererBox');
  await Hive.openBox<VehicleHiveObject>('vehicleBox');
  await Hive.openBox<Cart>('cartBox1');
  await Hive.openBox<Cart>('cartBox2');
  await Hive.openBox<Cart>('cartBox3');
  await Hive.openBox<Cart>('cartBox4');
  await Hive.openBox<Cart>('cartBox5');

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DelivererSkeleton(),
    );
  }
}
