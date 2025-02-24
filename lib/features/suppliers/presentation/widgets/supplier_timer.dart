import 'dart:async';
import 'package:flutter/material.dart';

class SupplierTimer extends StatefulWidget {
  final int startSeconds;
  final double fontSize;
  final Color textColor;

  const SupplierTimer({
    super.key,
    required this.startSeconds,
    required this.fontSize,
    required this.textColor,
  });

  @override
  State<SupplierTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<SupplierTimer> {
  Timer? _timer;
  late int remainingSeconds;
  bool isRunning = true;

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.startSeconds;
    _startCountdown();
  }

  void _startCountdown() {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds <= 0) {
        timer.cancel();
        setState(() {
          isRunning = false;
        });
        _showPopup();
      } else {
        setState(() {
          remainingSeconds--;
        });
      }
    });
  }

  void _showPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Tiempo finalizado"),
          content: const Text("Se pasará a la siguiente fase."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, '/orders');
              },
              child: const Text("Continuar"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          remainingSeconds <= 0 ? 'TIEMPO!' : _formatTime(),
          style: TextStyle(
            color: widget.textColor,
            fontSize: widget.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _formatTime() {
    int minutes = remainingSeconds ~/ 60;
    int seconds = remainingSeconds % 60;
    return '${minutes < 10 ? '0' : ''}$minutes:'
        '${seconds < 10 ? '0' : ''}$seconds';
  }
}
