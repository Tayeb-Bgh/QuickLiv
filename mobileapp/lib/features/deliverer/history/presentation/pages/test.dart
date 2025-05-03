import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/features/deliverer/history/presentation/widgets/CompleteOrderWidget.dart';

void main() {
  runApp(ProviderScope(child: MaterialApp(home: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CompleteOrderWidget();
  }
}
