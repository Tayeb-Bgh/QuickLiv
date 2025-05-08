import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:mobileapp/core/utils/location_provider.dart';
import 'package:mobileapp/features/customer/cart_popup/business/entities/business.dart';
import 'package:mobileapp/features/customer/cart_popup/data/models/cart_hive_object.dart';
import 'package:mobileapp/features/customer/groceries/business/entities/grocery_entity.dart';
import 'package:mobileapp/features/customer/restaurants/business/entities/restaurant_entity.dart';
import 'package:mobileapp/features/customer/restaurants/presentation/providers/restaurants_provider.dart';
import 'package:collection/collection.dart';

import '../../features/customer/groceries/presentation/providers/groceries_provider.dart';

class CartBoxUtils {
  static Future<String?> findAvailableCartBox(String targetCommerceId) async {
    const boxNames = [
      'cartBox1',
      'cartBox2',
      'cartBox3',
      'cartBox4',
      'cartBox5',
    ];

    for (final boxName in boxNames) {
      final box = Hive.box<Cart>(boxName);
      final cart = box.get('cart');

      if (cart != null && cart.id == targetCommerceId) {
        return boxName;
      }
    }

    for (final boxName in boxNames) {
      final box = Hive.box<Cart>(boxName);
      if (box.isEmpty) {
        return boxName;
      }
    }

    return null;
  }

  static Future<Business> findBusinessById(int idBusns, ref) async {
    final currentPos = await ref.read(locationProvider.future);
    final currentWilaya = await ref.read(
      wilayaProvider(LatLng(currentPos!.latitude, currentPos.longitude)).future,
    );

    final groceries = await ref
        .read(getGroceriesProvider)
        .call(currentWilaya, currentPos.latitude, currentPos.longitude);

    final restaurants = await ref.read(restaurantsListProvider.future);

    Grocery? grocery;
    for (var g in groceries) {
      if (g.id == idBusns) {
        grocery = g;
        break;
      }
    }

    Restaurant? restaurant;
    for (var r in restaurants) {
      if (r.id == idBusns) {
        restaurant = r;
        break;
      }
    }
   print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh   its works ${grocery?.name}  ${restaurant?.name}');
    return Business(
      idBusns: grocery?.id ?? restaurant?.id ?? 0,
      nameBusns: grocery?.name ?? restaurant!.name,
      delivPrice: grocery?.delivPrice ?? restaurant!.delivPrice,
      imgUrl: grocery?.imgUrl ?? restaurant!.imgUrl,
    );
  }
}
