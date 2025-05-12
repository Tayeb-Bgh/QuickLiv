import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/params/origin_dest_params.dart';
import 'package:mobileapp/core/utils/location_provider.dart';

class GoogleMapsPosToPos extends ConsumerStatefulWidget {
  final LatLng pointA;
  final LatLng marketPos;
  const GoogleMapsPosToPos({
    super.key,
    required this.pointA,
    required this.marketPos,
  });

  @override
  ConsumerState<GoogleMapsPosToPos> createState() => _GoogleMapsPosToPosState();
}

class _GoogleMapsPosToPosState extends ConsumerState<GoogleMapsPosToPos> {
  @override
  Widget build(BuildContext context) {
    final polylineTwoPointRoute = ref.watch(
      polylineTwoPointsProvider(
        OriginDestParams(origin: widget.pointA, destination: widget.marketPos),
      ),
    );

    final distanceInMetters = ref.watch(
      distanceInMetersProvider(
        OriginDestParams(origin: widget.pointA, destination: widget.marketPos),
      ),
    );

    final durationInSeconds = ref.watch(
      drivingDurationProvider(
        OriginDestParams(origin: widget.pointA, destination: widget.marketPos),
      ),
    );

    return polylineTwoPointRoute.when(
      data: (polylinePoints) {
        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: widget.pointA,
            zoom: 13,
          ),
          markers: {
            Marker(
              markerId: const MarkerId("Position actuelle"),
              position: widget.pointA,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure,
              ),
            ),
            Marker(
              markerId: const MarkerId("Market"),
              position: widget.marketPos,
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
  }
}
