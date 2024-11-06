import 'package:flutter/material.dart';

import '../widgets/unique.dart';

class HomePage extends StatelessWidget {
   
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Titulo'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Center(
               child: Text('HomePage'),
            ),
            UniqueValue(),
          ],
        ),
      ),
    );
  }
}