import 'package:flutter/material.dart';

class ResultDialog extends StatefulWidget {
  const ResultDialog({super.key, required this.registered, required this.message});
  final bool registered;
  final String message;

  @override
  State<ResultDialog> createState() => _ResultDialogState();
}

class _ResultDialogState extends State<ResultDialog> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );

    _animationController.forward(from: 0.2);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.registered
        ? correctScanDialog(widget.message)
        : inCorrectScanDialog(widget.message);
  }

  Widget correctScanDialog(String message) {
    return AlertDialog(
      title: const Center(child: Text('Registro exitoso')),
      content: SizedBox(
        height: 225,
        child: ScaleTransition(
          scale: _animation,
          child: const Icon(
            Icons.check_circle_outline_outlined,
            color: Colors.green,
            size: 200,
          ),
        ),
      ),
    );
  }

  Widget inCorrectScanDialog(String message) {
    return AlertDialog(
      title: Center(child: Text(message)),
      content: SizedBox(
        height: 225,
        child: ScaleTransition(
          scale: _animation,
          child: const Icon(
            Icons.cancel,
            color: Colors.red,
            size: 200,
          ),
        ),
      ),
    );
  }
}
