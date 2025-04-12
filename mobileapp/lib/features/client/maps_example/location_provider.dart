import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:mobileapp/core/config/location_config.dart';
import 'package:mobileapp/core/params/distance_params.dart';
import 'package:mobileapp/core/params/route_params.dart';
import 'package:mobileapp/core/config/distance_duration_service.dart';

final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

// Pour avoir la position actuelle de l utilisateur mais par contre ca s actualise pas quand il se deplace
final locationProvider = FutureProvider<LatLng?>((ref) async {
  final locationService = ref.read(locationServiceProvider);
  return await locationService.getUserPosition();
});

// Pour avoir la position actuelle de l utilisateur qui s actualise a chaque deplacement
final locationAutoRefreshProvider = StreamProvider<LatLng>((ref) {
  final locationService = ref.read(locationServiceProvider);
  return locationService.getUserPositionStream();
});

// Pour avoir une route tracer entre la position actuel et la destination
final polylineProvider = FutureProvider.family<List<LatLng>, LatLng>((
  ref,
  destination,
) async {
  final locationService = ref.read(locationServiceProvider);
  final currentPos = await locationService.getUserPosition();

  if (currentPos == null) throw Exception("Position actuelle introuvable");

  final polylinePoints = PolylinePoints();
  final result = await polylinePoints.getRouteBetweenCoordinates(
    googleApiKey: 'AIzaSyC0FIBQdjyucMIDJFyMRZK4QPdueX_U7Qs',
    request: PolylineRequest(
      origin: PointLatLng(currentPos.latitude, currentPos.longitude),
      destination: PointLatLng(destination.latitude, destination.longitude),
      mode: TravelMode.driving,
    ),
  );

  if (result.points.isEmpty) {
    throw Exception("Aucun point de route trouvé");
  }

  return result.points.map((e) => LatLng(e.latitude, e.longitude)).toList();
});

// Pour avoir une route tracer entre la position actuel et la destination
final polylineTwoPointsProvider = FutureProvider.family<List<LatLng>, RouteParams>((ref, params) async {
      try {
        final LatLng originPos = params.origin;
        final LatLng destinationPos = params.destination;

        final polylinePoints = PolylinePoints();
        final result = await polylinePoints.getRouteBetweenCoordinates(
          googleApiKey: 'AIzaSyC0FIBQdjyucMIDJFyMRZK4QPdueX_U7Qs',
          request: PolylineRequest(
            origin: PointLatLng(originPos.latitude, originPos.longitude),
            destination: PointLatLng(
              destinationPos.latitude,
              destinationPos.longitude,
            ),
            mode: TravelMode.driving,
          ),
        );

        if (result.points.isEmpty) {
          throw Exception("Aucun point de route trouvé");
        }

        return result.points
            .map((e) => LatLng(e.latitude, e.longitude))
            .toList();
      } catch (e) {
        print(e);
        throw e;
      }
    });

// Pour recuperer la distance en deux points
final distanceInMetersProvider = FutureProvider.family<double, DistanceParams>((ref, params) async {
  return await getDrivingDistanceInMeters(
    origin: params.origin,
    destination: params.destination,
  );
});

// Pour recuperer la duree de trajet entre deux points
final drivingDurationProvider = FutureProvider.family<int, DistanceParams>((ref, params) async {
  return await getDrivingDurationInSeconds(
    origin: params.origin,
    destination: params.destination,
  );
});