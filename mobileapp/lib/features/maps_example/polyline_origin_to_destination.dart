import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/params/origin_dest_params.dart';
import 'package:mobileapp/core/utils/location_provider.dart';

class GoogleMapsPage extends ConsumerStatefulWidget {
  const GoogleMapsPage({super.key});

  @override
  ConsumerState<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends ConsumerState<GoogleMapsPage> {
  final LatLng _pointA = LatLng(36.461175, 4.535769);
  final LatLng _marketPos = LatLng(36.5448475773023, 4.609514253196802);

  @override
  Widget build(BuildContext context) {
    final polylineTwoPointRoute = ref.watch(
      polylineTwoPointsProvider(
        OriginDestParams(origin: _pointA, destination: _marketPos),
      ),
    );

    final distanceInMetters = ref.watch(
      distanceInMetersProvider(
        OriginDestParams(origin: _pointA, destination: _marketPos),
      ),
    );

    final durationInSeconds = ref.watch(
      drivingDurationProvider(
        OriginDestParams(origin: _pointA, destination: _marketPos),
      ),
    );

    return polylineTwoPointRoute.when(
      data: (polylinePoints) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 19),
              child: SizedBox(
                height: 650,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _pointA,
                    zoom: 13,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId("Position actuelle"),
                      position: _pointA,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueAzure,
                      ),
                    ),
                    Marker(
                      markerId: const MarkerId("Market"),
                      position: _marketPos,
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
                ),
              ),
            ),
            distanceInMetters.when(
              data: (distance) {
                return durationInSeconds.when(
                  data: (duration) {
                    return Column(
                      children: [
                        Text(
                          "La distance entre les deux points est de : $distance m",
                        ),
                        Text(
                          "La duree de trajet entre les deux points est de : ${duration/60} min",
                        ),
                      ],
                    );
                  },
                  error: (e, _) => Center(child: Text("Erreur de route : $e")),
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                );
              },
              error: (e, _) => Center(child: Text("Erreur de route : $e")),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text("Erreur de route : $e")),
    );
  }
}
