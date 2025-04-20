import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/core/constants/constants.dart';

class CountdownTimer extends ConsumerStatefulWidget {
  const CountdownTimer({super.key});

  @override
  ConsumerState<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends ConsumerState<CountdownTimer> {
  late Timer _timer;
  int _secondsRemaining = 90 ;
  bool _isExpired = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _isExpired = true;
        });
        _timer.cancel();
      }
    });
  }

  String _formatDuration(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(darkModeProvider);
    final textColor = isDarkMode ? kPrimaryWhite : kPrimaryDark;

    if (_isExpired) {
      return Text(
        "Le code a expiré.",
        style: TextStyle(
          color: kPrimaryRed,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      );
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        children: [
          TextSpan(
            text: "Votre code expire dans : ",
            style: TextStyle(color: textColor),
          ),
          TextSpan(
            text: _formatDuration(_secondsRemaining),
            style: TextStyle(color: kPrimaryRed),
          ),
        ],
      ),
    );
  }
}
