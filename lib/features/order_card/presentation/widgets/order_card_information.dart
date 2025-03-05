import 'package:flutter/material.dart';

class OrderCardInformation extends StatelessWidget {

  final String recipeName;
  final int recipeQuantity;
  final int recipePrice;

  const OrderCardInformation({
    super.key,
    required this.recipeName,
    required this.recipeQuantity,
    required this.recipePrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10), // Espaciado interno uniforme
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            recipeName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('Cantidad: $recipeQuantity'),
          Text('Precio: \$$recipePrice'),
        ],
      ),
    );
  }
}
