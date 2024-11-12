import 'package:flutter/material.dart';

class InstructionsPage extends StatelessWidget {
   
  const InstructionsPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Titulo'),
      ),
      body: const Center(
         child: Text('InstrucctionsPage'),
      ),
    );
  }
}