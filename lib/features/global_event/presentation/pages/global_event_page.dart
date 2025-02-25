import 'package:flutter/material.dart';

import '../../../../core/utilities/utilities.dart';
import '../widgets/countdown_timer.dart';

class GlobalEventPage extends StatelessWidget {
  final Utilities utilities = Utilities();
  GlobalEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    // print('Cantidad de meses que se jugara ${utilities.getCacheGameDuration()}');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Evento Global'),
      ),
      body: Center(
        // child: Text('Página de eventos globales ${utilities.getInGameRecipesGroup()}'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Mes actual ${utilities.getCurrentMonthText()}'),
            const CountdownTimer(
              startSeconds: 10,
              fontSize: 50,
              textColor: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}