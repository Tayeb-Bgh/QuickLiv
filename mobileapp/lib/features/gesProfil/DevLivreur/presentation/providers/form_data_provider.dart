import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormDataNotifier extends StateNotifier<Map<String, String>> {
  FormDataNotifier() : super({});

  void updateField(String field, String value) {
    state = {...state, field: value};
  }

  void clearField(String field) {
    state = {...state, field: ""};
  }

  void resetForm() {
    state = {};
  }
}

final formDataProvider =
    StateNotifierProvider<FormDataNotifier, Map<String, String>>((ref) {
  return FormDataNotifier();
});
