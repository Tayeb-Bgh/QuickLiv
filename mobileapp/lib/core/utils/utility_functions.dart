import 'dart:math';

int toMinuts(int seconds) {
  return seconds ~/ 60;
}

int toHour(int seconds) {
  return seconds ~/ 3600;
}

String parseTime(int seconds) {
  final int secondsMinusFive = seconds - 60 * 5;
  final int secondsPlusFive = seconds - 60 * 5;

  final int firstTimeInterval =
      secondsMinusFive < 3600
          ? toMinuts(secondsMinusFive)
          : toHour(secondsMinusFive);

  final int finalTimeInterval =
      secondsPlusFive < 3600
          ? toMinuts(secondsPlusFive)
          : toHour(secondsPlusFive);

  return firstTimeInterval < 60 && finalTimeInterval >= 60
      ? "$firstTimeInterval min - $finalTimeInterval h"
      : firstTimeInterval >= 60 && finalTimeInterval >= 60
      ? "$firstTimeInterval - $finalTimeInterval h"
      : "$finalTimeInterval - $finalTimeInterval min";
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
