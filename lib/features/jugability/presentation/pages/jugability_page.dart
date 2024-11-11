import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/jugability_bloc.dart';
import '../widgets/widgets.dart';

class JugabilityPage extends StatelessWidget {
  const JugabilityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content(),
    );
  }

  BlocProvider<JugabilityBloc> content() {
    return BlocProvider(
      create: (context) => sl<JugabilityBloc>(),
      child: BlocBuilder<JugabilityBloc, JugabilityState>(
        builder: (context, state) {
          if (state is JugabilityLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is JugabilityLoaded) {
            return buildForm(context);
          }
          if (state is JugabilityInitial) {
            context.read<JugabilityBloc>().add(LoadGameEvent());
          }
          return const Center(
            child: Text('Error en la carga del menu'),
          );
        },
      ),
    );
  }

  Widget buildForm(BuildContext context) {
    double imagewith = MediaQuery.of(context).size.width / 3 - 30;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        cards(imagewith),
        SizedBox(
          width: MediaQuery.of(context).size.width - 50,
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(50, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Icon(Icons.menu),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Column(
                        children: [
                          Text('Calorias', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text('6'),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Column(
                        children: [
                          Text('Impuestos', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text('5'),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Column(
                        children: [
                          Text('Mes', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text('Enero'),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
