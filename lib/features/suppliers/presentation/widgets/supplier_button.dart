import 'package:flutter/material.dart';

import '../../domain/entities/supplier_item.dart';

class SupplierButton extends StatelessWidget {
  final SupplierItem item;

  const SupplierButton({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Acción al hacer clic
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Seleccionaste: ${item.name}"),
        ));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10), // Bordes redondeados opcionales
            child: Image.network(
              item.image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: 100,
            padding: const EdgeInsets.symmetric(vertical: 5),
            alignment: Alignment.center,
            color: Colors.blue, // Fondo para unificar con la imagen
            child: Text(
              item.name,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
