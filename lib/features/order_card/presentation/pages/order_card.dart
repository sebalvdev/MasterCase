import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/order_card_bloc.dart';
import '../widgets/countdown_progress_bar.dart';
import '../widgets/order_card_image.dart';
import '../widgets/order_card_information.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return cardBody(context);
  }

  BlocProvider<OrderCardBloc> cardBody(BuildContext context) {
    const int countdownTime = 30;
    return BlocProvider(
      create: (BuildContext context) => sl<OrderCardBloc>(),
      child: Center(
        child: BlocBuilder<OrderCardBloc, OrderCardState>(
          builder: (BuildContext context, OrderCardState state) {
            if (state is OrderCardInitial) {
              BlocProvider.of<OrderCardBloc>(context)
                  .add(const GetOrderCardInfoEvent());
            }

            if (state is OrderCardLoading) {
              return const CircularProgressIndicator();
            }

            if (state is OrderCardLoaded) {
              // Utilities utilities = Utilities();
              // List<String> restaurants = utilities.getPlayersRestaurantNames();
              return GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20), // Espaciado extra en la parte inferior
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Bordes redondeados
                    ),
                    elevation: 5, // Efecto de sombra
                    child: Container(
                      width: 220, // Aumentar el ancho de la tarjeta
                      padding: const EdgeInsets.all(0), // Eliminar espacio extra en los bordes
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CountdownProgressBar(
                              durationInSeconds: countdownTime,
                              onComplete: () {
                                BlocProvider.of<OrderCardBloc>(context)
                                    .add(const GetOrderCardInfoEvent());
                              }),
                          OrderCardImage(orderCardImage: state.orderCardInfo.recipeImage),
                          OrderCardInformation(
                            recipeName: state.orderCardInfo.recipeName,
                            recipeQuantity: state.orderCardInfo.recipeQuantity,
                            recipePrice: state.orderCardInfo.recipePrice,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }

            return const Text('Tarjetas de pedido');
          },
        ),
      ),
    );
  }
}
