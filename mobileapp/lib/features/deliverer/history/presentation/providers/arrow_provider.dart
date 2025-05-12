import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpandedNotifier extends StateNotifier<bool> {
  ExpandedNotifier() : super(false);
  
  void toggle() => state = !state;
}

final expandedProviderFamily = StateNotifierProvider.family<ExpandedNotifier, bool, int>(
  (ref, id) => ExpandedNotifier(),
);