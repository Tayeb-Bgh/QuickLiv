import 'dart:math';

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
      ? "${firstTimeInterval}min-${toHour(secondsPlusFive)}h"
      : firstTimeInterval >= 60 && finalTimeInterval >= 60
      ? "${toHour(secondsMinusFive)}-${toHour(secondsPlusFive)}h"
      : "$firstTimeInterval-${finalTimeInterval}min";
}

String formatPhone(String input) {
  List<int> spacePositions = [4, 6, 8];
  StringBuffer buffer = StringBuffer();

  int currentPosition = 0;
  input = '0$input';
  for (int i = 0; i < input.length; i++) {
    if (spacePositions.contains(currentPosition)) {
      buffer.write(' ');
    }
    buffer.write(input[i]);
    currentPosition++;
  }
  return buffer.toString();
}

double toKilometers(double metersDistance) {
  return metersDistance / 1000;
}

double calculateDelivPrice(double kilometersDistance) {
  // ! IL FAUT PASSER LA DISTANCE EN KILOMOTRES DONCT D'UTILISER CETTE FONCTION APPELEZ toKilometers()

  print("DEBUG distance : $kilometersDistance kilomètres");

  return kilometersDistance * 125;
}

double getPriceWithReduction(double price, double? reduction) {
  if (reduction == null) return price;

  return price - price * reduction / 100;
}

String capitalize(String text) {
  if (text.isEmpty) {
    return text;
  }
  return text[0].toUpperCase() + text.substring(1);
}

String generateRandomCode(List<String> predefinedCodes) {
  final random = Random();
  int index = random.nextInt(predefinedCodes.length);
  return predefinedCodes[index];
}

double calculateProgress(int currentPoints) {
  return (currentPoints / 1000).clamp(0, 1);
}

int remainingPointsForMilestone(int currentPoints) {
  return (1000 - currentPoints).clamp(0, 1000);
}

double gramsToKilograms(num grams) {
  return grams / 1000;
}

String formatDurationInReadableText(int seconds) {
  final int hours = seconds ~/ 3600;
  final int minutes = (seconds % 3600) ~/ 60;

  if (hours > 0 && minutes > 0) {
    return '$hours h $minutes min';
  } else if (hours > 0) {
    return '$hours h';
  } else {
    return '$minutes min';
  }
}

dynamic gramsToKg(int quantity) {
  double result = quantity / 1000;
  return result % 1 == 0 ? result.toInt() : result;
}

double roundToTwoDecimals(double value) {
  return double.parse(value.toStringAsFixed(2));
}
