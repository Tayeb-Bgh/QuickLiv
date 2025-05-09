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
  @override
  Widget build(BuildContext context) {
    final location = ref.watch(locationAutoRefreshProvider);

    return location.when(
      data: (LatLng? currentPosition) {
        if (currentPosition == null) {
          return const Center(
            child: Text("Impossible de récupérer la position"),
          );
        }
        // Juste afficher 1 point et notre position actuelle
        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: currentPosition,
            zoom: 16,
          ),
          markers: {
            Marker(
              markerId: const MarkerId("Position actuelle"),
              position: currentPosition,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure,
              ),
            ),
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text("Erreur: $err")),
    );
  }
}
