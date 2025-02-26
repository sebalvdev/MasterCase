import 'dart:async';
import 'package:flutter/material.dart';

class CountdownProgressBar extends StatefulWidget {
  final int durationInSeconds;
  final VoidCallback onComplete; // Acción al completar el progreso

  const CountdownProgressBar({
    super.key,
    required this.durationInSeconds,
    required this.onComplete,
  });

  @override
  _CountdownProgressBarState createState() => _CountdownProgressBarState();
}

class _CountdownProgressBarState extends State<CountdownProgressBar> {
  late Timer _timer;
  double _progress = 0.0;
  int _remainingTime = 0;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.durationInSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _progress += 1 / (widget.durationInSeconds * 10);
          _remainingTime = (widget.durationInSeconds * (1 - _progress)).ceil();
        });
      } else {
        _timer.cancel();
        widget.onComplete(); // Ejecutar la acción cuando termine
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: _progress,
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          minHeight: 8,
        ),
      ],
    );
  }
}