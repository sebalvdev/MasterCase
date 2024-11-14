import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_case/core/constants/color_constants.dart';
import 'package:master_case/features/jugability/data/model/meal_model.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/round_info.dart';
import '../bloc/jugability_bloc.dart';
import '../widgets/lateral_menu.dart';
import '../widgets/widgets.dart';

class JugabilityPage extends StatelessWidget {
  const JugabilityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LateralMenu(
        context: context,
      ),
      backgroundColor: black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/fondo.png',
              fit: BoxFit.cover,
            ),
          ),
          content(),
        ],
      ),
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
            return buildForm(context, state.roundInfo.meals, state.roundInfo);
          }
          if (state is JugabilityInitial) {
            context.read<JugabilityBloc>().add(LoadGameEvent());
          }
          if (state is JugabilityFinish) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.gameOver,
                (route) => false,
              );
            });
          }
          return const Center(
            child: Text('Error en la carga del menu'),
          );
        },
      ),
    );
  }

  Widget buildForm(
      BuildContext context, List<MealModel> meals, RoundInfo data) {
    double imageWith = MediaQuery.of(context).size.width / 3 - 30;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FlipCard(images: meals, imageWidth: imageWith, month: data.month),
        bottomInfo(context, data.calories.toString(), data.taxes.toString(),
            data.month)
      ],
    );
  }
}
