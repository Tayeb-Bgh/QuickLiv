import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapp/features/pick_location/providers/pick_location_providers.dart';

class LocationDisplay extends ConsumerWidget {
  final LatLng position;

  const LocationDisplay({Key? key, required this.position}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressAsync = ref.watch(formattedAddressProvider(position));
    final dmsCoordinates = formatPositionAsDMS(position);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Coordonnées: $dmsCoordinates",
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 8),
        addressAsync.when(
          data:
              (address) => Text(
                "Adresse: $address",
                style: const TextStyle(fontSize: 14),
              ),
          loading: () => const Text("Chargement de l'adresse..."),
          error: (e, _) => Text("Erreur: $e"),
        ),
      ],
    );
  }
}
