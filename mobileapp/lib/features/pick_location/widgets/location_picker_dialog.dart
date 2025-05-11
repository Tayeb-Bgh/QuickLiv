import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/pick_location/providers/pick_location_providers.dart';

class LocationPickerDialog extends ConsumerStatefulWidget {
  const LocationPickerDialog({super.key});

  @override
  ConsumerState<LocationPickerDialog> createState() =>
      _LocationPickerDialogState();
}

class _LocationPickerDialogState extends ConsumerState<LocationPickerDialog> {
  LatLng? _tempPosition;
  bool _loading = true;
  String? _currentAddress;
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    // Vérifier d'abord s'il existe déjà une position confirmée
    final existingPosition = ref.read(confirmedPositionProvider);
    if (existingPosition != null) {
      await _updatePositionAndAddress(existingPosition);
      return;
    }

    try {
      final position = await _getCurrentPosition();
      await _updatePositionAndAddress(
        LatLng(position.latitude, position.longitude),
      );
    } catch (e) {
      const fallback = LatLng(36.7525, 3.0420);
      await _updatePositionAndAddress(fallback);
    }
  }

  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled';
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied';
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _updatePositionAndAddress(LatLng position) async {
    setState(() {
      _loading = true;
    });

    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final p = placemarks.isNotEmpty ? placemarks.first : null;

      if (mounted) {
        setState(() {
          _tempPosition = position;
          _currentAddress =
              p != null
                  ? "${p.street ?? ''}, ${p.locality ?? ''}, ${p.country ?? ''}"
                  : "Adresse inconnue";
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _tempPosition = position;
          _currentAddress = "Impossible de récupérer l'adresse";
          _loading = false;
        });
      }
    }
  }

  Future<void> _handlePositionUpdate(LatLng newPosition) async {
    await _mapController?.animateCamera(CameraUpdate.newLatLng(newPosition));
    await _updatePositionAndAddress(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Dialog(
      insetPadding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: screenSize.width * 0.95,
        height: screenSize.height * 0.75,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Choisir une position",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  if (_currentAddress != null)
                    Text(
                      _currentAddress!,
                      style: const TextStyle(fontSize: 14),
                    ),
                ],
              ),
            ),
            Expanded(
              child:
                  _loading || _tempPosition == null
                      ? const Center(child: CircularProgressIndicator())
                      : GoogleMap(
                        onMapCreated:
                            (controller) => _mapController = controller,
                        initialCameraPosition: CameraPosition(
                          target: _tempPosition!,
                          zoom: 14,
                        ),
                        markers: {
                          Marker(
                            markerId: const MarkerId("temp"),
                            position: _tempPosition!,
                            draggable: true,
                            onDragEnd: (pos) => _handlePositionUpdate(pos),
                          ),
                        },
                        onTap: (pos) => _handlePositionUpdate(pos),
                      ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: kPrimaryRed),
                    child: const Text("Annuler"),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryRed,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 24.0,
                      ),
                    ),
                    child: const Text("Confirmer"),
                    onPressed: () {
                      if (_tempPosition != null) {
                        // S'assurer que la mise à jour est bien prise en compte
                        ref.read(confirmedPositionProvider.notifier).state =
                            _tempPosition;

                        // Forcer l'invalidation du provider d'adresse
                        ref.invalidate(addressFromConfirmedProvider);
                      }
                      ref.read(isDefaultPositionSelected.notifier).state =
                          false;
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
