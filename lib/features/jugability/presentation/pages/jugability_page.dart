import 'package:flutter/material.dart';

class JugabilityPage extends StatelessWidget {
   
  const JugabilityPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Titulo'),
      ),
      body: const Center(
         child: Text('JugabilityPage'),
      ),
    );
  }
}