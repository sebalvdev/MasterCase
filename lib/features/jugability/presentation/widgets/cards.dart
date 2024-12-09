import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_case/core/utilities/utilities.dart';
import '../../data/model/meal_model.dart';
import '../bloc/jugability_bloc.dart';

class FlipCard extends StatefulWidget {
  final List<MealModel> images;
  final double imageWidth;
  final String month;

  const FlipCard({
    super.key,
    required this.images,
    required this.imageWidth,
    required this.month,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FlipCardDemoState createState() => _FlipCardDemoState();
}

class _FlipCardDemoState extends State<FlipCard> with TickerProviderStateMixin {
  late List<bool> isFlipped;
  late List<AnimationController> _controllers;
  late List<double> opacities;
  
  Utilities utilities = Utilities();

  @override
  void initState() {
    super.initState();
    isFlipped = List<bool>.filled(widget.images.length, false);
    opacities = List<double>.filled(widget.images.length, 0.0);
    utilities.saveCardState(isFlipped);
    // print('isFlipped estado inicial de cartas: $isFlipped');

    // Initialize an AnimationController for each card
    _controllers = List.generate(widget.images.length, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      )..addStatusListener((status) {
          if (status == AnimationStatus.completed &&
              isFlipped.every((flipped) => flipped)) {
            BlocProvider.of<JugabilityBloc>(context)
                // .add(NextRound(actualMonth: widget.month));
                .add(BetweenRounds(actualMonth: widget.month));
          }
        });
    });

    // Trigger the opacity animations one by one
    _triggerAppearAnimations();
  }

  void _triggerAppearAnimations() async {
    for (int i = 0; i < opacities.length; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() {
        opacities[i] = 1.0;
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.images.length, (index) {
          return AnimatedOpacity(
            opacity: opacities[index],
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isFlipped[index] = !isFlipped[index];
                  if (isFlipped[index]) {
                    _controllers[index].forward(from: 0.0);
                    // print('isFlipped: $isFlipped');
                    utilities.saveCardState(isFlipped);
                  } else {
                    _controllers[index].reverse();                    
                  }
                });
              },
              child: AnimatedBuilder(
                animation: _controllers[index],
                builder: (context, child) {
                  final rotationValue = _controllers[index].value;
                  return Transform(
                    transform: Matrix4.rotationY(rotationValue * 3.1416),
                    alignment: Alignment.center,
                    child: rotationValue >= 0.5
                        ? SizedBox(
                            key: ValueKey('back_$index'),
                            width: widget.imageWidth,
                            height: widget.imageWidth,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Image.asset(
                                'assets/images/reverso.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : SizedBox(
                            key: ValueKey('front_$index'),
                            width: widget.imageWidth,
                            height: widget.imageWidth,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Image.asset(
                                widget.images[index].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
