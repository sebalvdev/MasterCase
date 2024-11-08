import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/jugability_bloc.dart';

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
    return const Center(child: Text('data'),);
  }
}