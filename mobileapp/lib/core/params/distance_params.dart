import 'package:google_maps_flutter/google_maps_flutter.dart';

class DistanceParams {
  final LatLng origin;
  final LatLng destination;

  DistanceParams({required this.origin, required this.destination});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DistanceParams &&
          origin.latitude == other.origin.latitude &&
          origin.longitude == other.origin.longitude &&
          destination.latitude == other.destination.latitude &&
          destination.longitude == other.destination.longitude;

  @override
  int get hashCode => Object.hash(
    origin.latitude,
    origin.longitude,
    destination.latitude,
    destination.longitude,
  );
}
