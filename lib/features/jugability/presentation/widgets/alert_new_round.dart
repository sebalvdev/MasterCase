import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class AlertNewRound extends StatefulWidget {
  final String actualMonth;

  const AlertNewRound({super.key, required this.actualMonth});

  @override
  // ignore: library_private_types_in_public_api
  _AlertNewRoundState createState() => _AlertNewRoundState();
}

class _AlertNewRoundState extends State<AlertNewRound>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Column(
          children: [
            SizedBox(width: 10),
            Icon(Icons.cached_sharp, color: yellow, size: 100,),
            Text("Nueva Ronda"),
          ],
        ),
        content: const Text(
          "Intercambien tarjetas de Precios.",
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Aceptar"),
          ),
        ],
      ),
    );
  }
}
