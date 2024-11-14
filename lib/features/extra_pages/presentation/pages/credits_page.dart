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
    utilities.fetchLoremIpsum(6).then((text) {
      setState(() {
        loremText = text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creditos'),
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Row(
          children: [
            SizedBox(
                width: 450,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(loremText),
                )),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network('https://picsum.photos/250'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network('https://picsum.photos/250'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network('https://picsum.photos/250'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network('https://picsum.photos/250'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network('https://picsum.photos/250'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network('https://picsum.photos/250'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network('https://picsum.photos/250'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network('https://picsum.photos/250'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network('https://picsum.photos/250'),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
