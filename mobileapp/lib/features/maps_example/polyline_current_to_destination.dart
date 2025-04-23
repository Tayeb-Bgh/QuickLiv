import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/utils/location_provider.dart';

class GoogleMapsPage extends ConsumerStatefulWidget {
  const GoogleMapsPage({super.key});

  @override
  ConsumerState<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends ConsumerState<GoogleMapsPage> {
  final LatLng _destinationPos = LatLng(36.5448475773023, 4.609514253196802);

  @override
  Widget build(BuildContext context) {
    final location = ref.watch(locationAutoRefreshProvider);
    final polylineRoute = ref.watch(polylineProvider(_destinationPos));

    return location.when(
      data: (LatLng? currentPosition) {
        if (currentPosition == null) {
          return const Center(
            child: Text("Impossible de récupérer la position"),
          );
        }

        // Afficher la route entre ta pos actuel et une destination
        return polylineRoute.when(
          data: (polylinePoints) {
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: currentPosition,
                zoom: 13,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("Position actuelle"),
                  position: currentPosition,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueAzure,
                  ),
                ),
                Marker(
                  markerId: const MarkerId("Market"),
                  position: _destinationPos,
                  icon: BitmapDescriptor.defaultMarker,
                ),
              },
              polylines: {
                Polyline(
                  polylineId: const PolylineId("route"),
                  color: Colors.blue,
                  width: 5,
                  points: polylinePoints,
                ),
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text("Erreur de route : $e")),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text("Erreur: $err")),
    );
  }
}
