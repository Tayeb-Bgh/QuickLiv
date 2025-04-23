import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/constants.dart';

class LoadingDialog extends StatelessWidget {
  final String message;

  const LoadingDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: kPrimaryRed),
          const SizedBox(height: 20),
          Text(message),
        ],
      ),
    );
  }
}

class ErrorDialog extends StatelessWidget {
  final String message;
  final VoidCallback onDismiss;

  const ErrorDialog({Key? key, required this.message, required this.onDismiss})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Erreur'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: onDismiss,
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class SuccessDialog extends StatelessWidget {
  final String message;
  final VoidCallback onDismiss;

  const SuccessDialog({Key? key, required this.message, required this.onDismiss})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Succès'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: onDismiss,
          child: const Text('OK'),
        ),
      ],
    );
  }
}