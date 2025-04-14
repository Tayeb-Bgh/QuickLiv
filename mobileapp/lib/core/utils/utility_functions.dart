import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

int toMinuts(int seconds) {
  return seconds ~/ 60;
}

int toHour(int seconds) {
  return seconds ~/ 3600;
}

String parseTime(int seconds) {
  const int fiveMinutes = 60 * 5;
  final int secondsMinusFive = seconds - fiveMinutes;
  final int secondsPlusFive = seconds + fiveMinutes;

  final int firstTimeInterval = toMinuts(secondsMinusFive);
  final int finalTimeInterval = toMinuts(secondsPlusFive);

  return firstTimeInterval < 60 && finalTimeInterval >= 60
      ? "$firstTimeInterval min - ${toHour(secondsPlusFive)} h"
      : firstTimeInterval >= 60 && finalTimeInterval >= 60
      ? "${toHour(secondsMinusFive)} - ${toHour(secondsPlusFive)} h"
      : "$firstTimeInterval - $finalTimeInterval min";
}

double toKilometers(double metersDistance) {
  return metersDistance / 1000;
}

double calculateDelivPrice(double kilometersDistance) {
  // ! IL FAUT PASSER LA DISTANCE EN KILOMOTRES DONCT D'UTILISER CETTE FONCTION APPELEZ toKilometers()
  return kilometersDistance * 125;
}

double getPriceWithReduction(double price, double reduction) {
  return price * reduction;
}
