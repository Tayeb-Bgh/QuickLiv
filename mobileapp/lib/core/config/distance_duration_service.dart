import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

Future<double> getDrivingDistanceInMeters({
  required LatLng origin,
  required LatLng destination,
}) async {
  final String url =
      'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&mode=driving&key=AIzaSyC0FIBQdjyucMIDJFyMRZK4QPdueX_U7Qs';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    final distanceMeters = json['routes'][0]['legs'][0]['distance']['value'];
    return distanceMeters.toDouble(); // en mètres
  } else {
    throw Exception('Erreur lors de la récupération de la distance');
  }
}

Future<int> getDrivingDurationInSeconds({
  required LatLng origin,
  required LatLng destination,
}) async {
  final String url =
      'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&mode=driving&key=AIzaSyC0FIBQdjyucMIDJFyMRZK4QPdueX_U7Qs';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    final durationSeconds = json['routes'][0]['legs'][0]['duration']['value'];
    return durationSeconds.toInt(); // en secondes
  } else {
    throw Exception('Erreur lors de la récupération de la durée');
  }
}

