import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_case/features/order_card/presentation/widgets/countdown_progress_bar.dart';

import '../../../../injection_container.dart';
import '../bloc/order_card_bloc.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return cardBody(context);
  }

  BlocProvider<OrderCardBloc> cardBody(BuildContext context) {
    final int countdownTime = 30;
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
              return Padding(
                padding: const EdgeInsets.only(
                    bottom: 20), // Espaciado extra en la parte inferior
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15), // Bordes redondeados
                  ),
                  elevation: 5, // Efecto de sombra
                  child: Container(
                    width: 220, // Aumentar el ancho de la tarjeta
                    padding: const EdgeInsets.all(
                        0), // Eliminar espacio extra en los bordes
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CountdownProgressBar(
                            durationInSeconds: countdownTime,
                            onComplete: () {
                              BlocProvider.of<OrderCardBloc>(context)
                                  .add(const GetOrderCardInfoEvent());
                            }),
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(
                                15), // Bordes redondeados arriba
                          ),
                          child: Image.network(
                            state.orderCardInfo.recipeImage,
                            height:
                                200, // La imagen ocupa la mitad de la tarjeta
                            width: double.infinity,
                            fit: BoxFit
                                .cover, // La imagen cubre todo el ancho sin distorsión
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(
                              10), // Espaciado interno uniforme
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // const Text(
                              //   'PEDIDO',
                              //   style: TextStyle(fontWeight: FontWeight.bold),
                              // ),
                              // SizedBox(height: 25),
                              Text(
                                '${state.orderCardInfo.recipeName}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  'Cantidad: ${state.orderCardInfo.recipeQuantity}'),
                              Text(
                                  'Precio: \$${state.orderCardInfo.recipePrice}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return const Text('Error al cargar la tarjeta de pedido');
          },
        ),
      ),
    );
  }
}
