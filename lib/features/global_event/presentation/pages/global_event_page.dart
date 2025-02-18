import 'package:flutter/material.dart';
import 'package:master_case/core/utilities/utilities.dart';
import 'package:master_case/features/global_event/presentation/widgets/countdown_timer.dart';

class GlobalEventPage extends StatelessWidget {
  final Utilities utilities = Utilities();
  GlobalEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('Cantidad de meses que se jugara ${utilities.getCacheGameDuration()}');
    return Scaffold(
      appBar: AppBar(
        
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