import 'package:flutter/material.dart';
import 'package:master_case/core/utilities/utilities.dart';

class GlobalEventPage extends StatelessWidget {
  final Utilities utilities = Utilities();
  GlobalEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos globales'),
      ),
      body: Center(
        child: Text('Página de eventos globales ${utilities.getInGameRecipesGroup()}'),
      ),
    );
  }
}