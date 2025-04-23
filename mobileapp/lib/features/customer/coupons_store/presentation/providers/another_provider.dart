import 'package:flutter_riverpod/flutter_riverpod.dart';

class PointNotifier extends StateNotifier<int> {
  PointNotifier() : super(1500); // Valeur initiale des points

  void addPoints(int amount) {
    state = state + amount;
  }

  void spendPoints(int amount) {
    if (state >= amount) {
      state = state - amount;
    }
  }
}

final pointProvider = StateNotifierProvider<PointNotifier, int>((ref) {
  return PointNotifier();
});