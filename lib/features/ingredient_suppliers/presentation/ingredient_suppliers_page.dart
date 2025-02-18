import 'package:flutter/material.dart';

class IngredientSuppliersPage extends StatelessWidget {
  const IngredientSuppliersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proveedores de Ingredientes'),
      ),
      body: const Center(
        child: Text('Página de proveedores de ingredientes'),
      ),
    );
  }
}