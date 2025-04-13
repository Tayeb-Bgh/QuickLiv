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
