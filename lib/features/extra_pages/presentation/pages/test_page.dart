import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  // ! implicita
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animación Implícita")),
      body: Center(
        child: AnimatedContainer(
          width: _isExpanded ? 200 : 100,
          height: _isExpanded ? 200 : 100,
          color: _isExpanded ? Colors.blue : Colors.red,
          duration: const Duration(seconds: 2), // Duración de la animación
          curve: Curves.elasticOut, // Curva de animación
          child: const Center(child: Text("Haz click")),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isExpanded =
                !_isExpanded; // Cambia el estado para activar la animación
          });
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }

// ! with opacy

  // bool _isVisible = true;

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: const Text("Animación de Opacidad")),
  //     body: Center(
  //       child: AnimatedOpacity(
  //         opacity: _isVisible ? 1.0 : 0.0,
  //         duration: const Duration(seconds: 2),
  //         curve: Curves.easeInOut,
  //         child: Container(
  //           width: 100,
  //           height: 100,
  //           color: Colors.blue,
  //         ),
  //       ),
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: () {
  //         setState(() {
  //           _isVisible = !_isVisible;
  //         });
  //       },
  //       child: const Icon(Icons.visibility),
  //     ),
  //   );
  // }

// ! explicita

// class _TestPageState extends State<TestPage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this, // Necesario para sincronizar la animación con el renderizado
//     );

//     _animation = Tween<double>(begin: 100, end: 200).animate(
//       // CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//       CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
//     );

//     // Repetir la animación infinitamente
//     _controller.repeat(reverse: true);
//   }

//   @override
//   void dispose() {
//     _controller.dispose(); // Liberar el controlador al salir
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Animación Explícita")),
//       body: Center(
//         child: AnimatedBuilder(
//           animation: _animation,
//           builder: (context, child) {
//             return Container(
//               width: _animation.value,
//               height: _animation.value,
//               color: Colors.blue,
//             );
//           },
//         ),
//       ),
//     );
//   }
}
