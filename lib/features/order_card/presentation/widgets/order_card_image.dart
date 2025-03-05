import 'package:flutter/material.dart';

class OrderCardImage extends StatelessWidget {
  final String orderCardImage;
  const OrderCardImage({
    super.key,
    required this.orderCardImage,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(15), // Bordes redondeados arriba
      ),
      child: Image.network(
        orderCardImage,
        height: 200, // La imagen ocupa la mitad de la tarjeta
        width: double.infinity,
        fit: BoxFit.cover, // La imagen cubre todo el ancho sin distorsión
      ),
    );
  }
}
