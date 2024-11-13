import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/meal_model.dart';
import '../bloc/jugability_bloc.dart';

class FlipCard extends StatefulWidget {
  final List<MealModel> images;
  final double imageWith;
  final String month;

  const FlipCard({super.key, required this.images, required this.imageWith, required this.month});

  @override
  // ignore: library_private_types_in_public_api
  _FlipCardDemoState createState() => _FlipCardDemoState();
}

class _FlipCardDemoState extends State<FlipCard> {
  late List<bool> isFlipped;

  @override
  void initState() {
    super.initState();
    isFlipped = List<bool>.filled(widget.images.length, false);
  }

  @override
  Widget build(BuildContext context) {

    return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.images.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  // Toggle the flip state on tap
                  isFlipped[index] = !isFlipped[index];

                  // verify state of cards
                  if (isFlipped.every((flipped) => flipped)) {
                  BlocProvider.of<JugabilityBloc>(context).add((NextRound(actualMonth: widget.month)));
                }
                });
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  // return RotationTransition(
                  return ScaleTransition(
                    // turns: Tween(begin: 0.0, end: 1.0).animate(animation),
                    scale: Tween(begin: 0.0, end: 1.0).animate(animation),
                    child: child,
                  );
                },
                child: isFlipped[index]
                    ? SizedBox(
                        key: ValueKey('back_$index'),
                        width: widget.imageWith,
                        height: widget.imageWith,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Image.asset(
                            'assets/images/reverso.jpg', // Image for the reverse side
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    : SizedBox(
                        key: ValueKey('front_$index'),
                        width: widget.imageWith,
                        height: widget.imageWith,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Image.asset(
                            widget.images[index].image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
              ),
            );
          }),
        ),
    );
  }
}
