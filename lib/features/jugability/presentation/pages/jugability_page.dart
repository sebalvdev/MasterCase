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
          if (state is JugabilityNewRound) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await showAnimatedPopup(context, state.actualMonth);
              // ignore: use_build_context_synchronously
              context
                  .read<JugabilityBloc>()
                  .add(NextRound(actualMonth: state.actualMonth));
            });
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
    double imageWith = MediaQuery.of(context).size.width / 3 - 10;
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        FlipCard(images: meals, imageWidth: imageWith, month: data.month),
        bottomInfo(context, data.calories.toString(), data.taxes.toString(),
            data.month),
        names(),
      ],
    );
  }

  Widget betweenRounds(
      BuildContext context, List<MealModel> meals, RoundInfo data) {
    return Stack(
      children: [
        bottomInfo(context, data.calories.toString(), data.taxes.toString(),
            data.month),
        names(),
      ],
    );
  }

  /// Función para mostrar el popup animado
  Future<void> showAnimatedPopup(
      BuildContext context, String actualMonth) async {
    await showDialog(
      context: context,
      barrierDismissible:
          false, // Impide cerrar al hacer clic fuera del diálogo
      builder: (BuildContext context) {
        return AlertNewRound(
          actualMonth: actualMonth,
        );
      },
    );
  }
}
