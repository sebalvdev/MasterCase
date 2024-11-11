import 'package:flutter/material.dart';

class CreditsPage extends StatelessWidget {
   
  const CreditsPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Titulo'),
      ),
      body: const Center(
         child: Text('CreditsPage'),
      ),
    );
  }
}