import 'package:flutter/material.dart';

import '../../../../core/utilities.dart';

class CreditsPage extends StatefulWidget {
  const CreditsPage({super.key});

  @override
  State<CreditsPage> createState() => _CreditsPageState();
}

class _CreditsPageState extends State<CreditsPage> {
  Utilities utilities = Utilities();
  String loremText = "Cargando...";

  @override
  void initState() {
    super.initState();
    utilities.fetchLoremIpsum(2).then((text) {
      setState(() {
        loremText = text;
      });
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
        title: const Text('Titulo'),
    ),
    body: Center(
       child: Text(loremText),
    ),
  );
}
}
