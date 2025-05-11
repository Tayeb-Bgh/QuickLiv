import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapp/core/utils/location_provider.dart';

final isDefaultPositionSelected = StateProvider<bool>((ref) {
  return true;
});

final confirmedPositionProvider = StateProvider<LatLng?>((ref) => null);

final defaultPositionProvider = FutureProvider<LatLng?>((ref) async {
  LatLng? pos = await ref.watch(locationProvider.future);
  return pos;
});

final addressFromConfirmedProvider = FutureProvider<String?>((ref) async {
  final position = ref.watch(confirmedPositionProvider);
  if (position == null) return null;

  try {
    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (placemarks.isNotEmpty) {
      final p = placemarks.first;
      return "${p.street ?? ''}, ${p.locality ?? ''}, ${p.country ?? ''}";
    }
    return "Aucune adresse trouvée.";
  } catch (e) {
    return "Erreur de récupération d'adresse";
  }
});

Future<String> formatPositionAsAddress(LatLng position) async {
  try {
    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      final p = placemarks.first;

      // Création d'une liste des composants d'adresse non vides
      final components =
          [
            p.name,
            p.street,
            p.subLocality,
            p.locality,
            p.subAdministrativeArea,
            p.administrativeArea,
            p.country,
          ].where((element) => element != null && element.isNotEmpty).toList();

      // Filtrer les doublons éventuels et limiter à 3 éléments les plus significatifs
      final uniqueComponents = components.toSet().toList();
      final significantComponents = uniqueComponents.take(3).toList();

      if (significantComponents.isNotEmpty) {
        return significantComponents.join(", ");
      }
    }

    return "Adresse inconnue";
  } catch (e) {
    return "Erreur de récupération d'adresse";
  }
}

/// Convertit un nombre décimal en notation degrés, minutes, secondes
/// avec la direction (N/S pour latitude, E/W pour longitude)
String _decimalToDMS(double decimal, bool isLatitude) {
  // Gérer le signe
  String direction = "";
  if (isLatitude) {
    direction = decimal >= 0 ? "N" : "S";
  } else {
    direction = decimal >= 0 ? "E" : "W";
  }

  // Valeur absolue pour le calcul
  decimal = decimal.abs();

  // Calculer degrés, minutes, secondes
  final degrees = decimal.floor();
  final minutesDecimal = (decimal - degrees) * 60;
  final minutes = minutesDecimal.floor();
  final seconds = ((minutesDecimal - minutes) * 60).floor();

  // Formater en chaîne de caractères
  return "$degrees° $minutes' $seconds\" $direction";
}

/// Transforme une position GPS (LatLng) en coordonnées au format DMS
/// Exemple: "48° 51' 24\" N, 2° 21' 8\" E"
String formatPositionAsDMS(LatLng position) {
  final latDMS = _decimalToDMS(position.latitude, true);
  final lngDMS = _decimalToDMS(position.longitude, false);

  return "$latDMS, $lngDMS";
}

// Extension sur LatLng pour faciliter l'utilisation
extension LatLngFormatting on LatLng {
  Future<String> toAddressString() async {
    return formatPositionAsAddress(this);
  }

  String toDMSString() {
    return formatPositionAsDMS(this);
  }
}

// Exemple d'utilisation des fonctions avec Riverpod
final formattedAddressProvider = FutureProvider.family<String, LatLng>((
  ref,
  position,
) async {
  return formatPositionAsAddress(position);
});

final formattedDMSProvider = Provider.family<String, LatLng>((ref, position) {
  return formatPositionAsDMS(position);
});
