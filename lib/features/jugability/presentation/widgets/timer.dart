// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_case/features/jugability/presentation/bloc/jugability_bloc.dart';

class CardTimer extends StatefulWidget {
  final int startSeconds;
  final double fontSize;
  final Color textColor;

  const CardTimer({
    super.key,
    required this.startSeconds,
    required this.fontSize,
    required this.textColor,
  });

  @override
  State<CardTimer> createState() => _CardTimerState();
}

class _CardTimerState extends State<CardTimer> {
  Timer? _timer;
  late int remainingSeconds; // Instancia del reproductor de audio

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
        timer.cancel(); // Reproducir la alarma cuando el tiempo llegue a 0
      } else {
        setState(() {
          remainingSeconds--;
        });
      }
    });
  }


  @override
  void dispose() {
    _timer?.cancel();  // Cancelamos el temporizador cuando el widget se destruye  // Liberamos recursos del reproductor de audio
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      remainingSeconds <= 0 ? _endTimerText() : _formatTime(),
      style: TextStyle(
        color: widget.textColor,
        fontSize: widget.fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  String _formatTime() {
    int minutes = remainingSeconds ~/ 60;
    int seconds = remainingSeconds % 60;
    return '${minutes < 10 ? '0' : ''}$minutes:'
           '${seconds < 10 ? '0' : ''}$seconds';
  }

  String _endTimerText() {
    BlocProvider.of<JugabilityBloc>(context).add(const TimerExpiredEvent());
    return 'TIEMPO!';
  }
}
