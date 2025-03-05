import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../config/routes/app_routes.dart';

class SimpleTimer extends StatefulWidget {
  final int startSeconds;
  final double fontSize;
  final Color textColor;

  const SimpleTimer({
    super.key,
    required this.startSeconds,
    required this.fontSize,
    required this.textColor,
  });

  @override
  State<SimpleTimer> createState() => _SimpleTimerState();
}

class _SimpleTimerState extends State<SimpleTimer> {
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
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('¡Tiempo! La fase de venta ha terminado'),
            content: const Text('Puede continuar con la siguiente fase.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, AppRoutes.management);
                },
                child: const Text('Cerrar'),
              ),
            ],
          ),
        );
      } else {
        setState(() {
          remainingSeconds--;
        });
      }
    });
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
        // const SizedBox(height: 20),
        // ElevatedButton(
        //   onPressed: isRunning ? null : () {
        //     Navigator.popAndPushNamed(context, '/ingredient_suppliers');
        //   },
        //   child: const Text('Botón habilitado al finalizar'),
        // ),
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