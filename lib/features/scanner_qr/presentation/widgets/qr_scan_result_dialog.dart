import 'package:flutter/material.dart';

class QRScanResultDialog extends StatefulWidget {
  const QRScanResultDialog({super.key, required this.isScanCorrect});

  final bool isScanCorrect;

  @override
  State<QRScanResultDialog> createState() => _QRScanResultDialogState();
}

class _QRScanResultDialogState extends State<QRScanResultDialog>
    with SingleTickerProviderStateMixin {
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
    return widget.isScanCorrect ? correctScanDialog() : incorrectScanDialog();
  }

  Widget correctScanDialog() {
    return AlertDialog(
      title: const Center(child: Text('QR correcto')),
      content: SizedBox(
        height: 225,
        child: ScaleTransition(
          scale: _animation,
          child: const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 200,
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }

  Widget incorrectScanDialog() {
    return AlertDialog(
      title: const Text('Codigo QR incorrecto'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Codigo QR incorrecto'),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
