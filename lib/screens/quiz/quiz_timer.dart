import 'dart:async';
import 'package:flutter/material.dart';

class QuizTimer {
  final int duration;
  final Function(int) onTick;
  final VoidCallback onFinished;
  Timer? _timer;
  int _timeLeft;
  bool _isActive = false;

  QuizTimer({
    required this.duration,
    required this.onTick,
    required this.onFinished,
  }) : _timeLeft = duration;

  void start() {
    if (_isActive) return;
    _isActive = true;
    _timeLeft = duration;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        _timeLeft--;
        onTick(_timeLeft);
      } else {
        stop();
        onFinished();
      }
    });
  }

  void stop() {
    _timer?.cancel();
    _isActive = false;
  }

  void dispose() {
    stop();
  }
}
