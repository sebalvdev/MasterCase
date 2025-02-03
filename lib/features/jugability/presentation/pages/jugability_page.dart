import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../core/utilities/utilities.dart';
import '../../../../injection_container.dart';
import '../../data/model/meal_model.dart';
import '../../data/model/round_info_model.dart';
import '../../domain/entities/round_info.dart';
import '../bloc/jugability_bloc.dart';
import '../widgets/lateral_menu.dart';
import '../widgets/widgets.dart';

// ignore: must_be_immutable
class JugabilityPage extends StatelessWidget {
  Utilities utilities = Utilities();

  JugabilityPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return Scaffold(
      drawer: LateralMenu(
        context: context,
      ),
      backgroundColor: black,
      body: Stack(
        children: [
          // Contenido en la parte inferior
          // Positioned.fill(
          //   child: Image.asset(
          //     'assets/images/primeraOpcionFondoWelcome.png',
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // color: Colors.black.withOpacity(0.6),
            color: white,
            child: content(),
          ),
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
            // print('loading state');
            return const Center(
                child: CircularProgressIndicator(
              color: white,
            ));
          }
          if (state is JugabilityLoaded) {
            // print('1');
            // print('JugabilityLoaded state');
            utilities.saveCurrentRoundInfoInCache(state.roundInfo);
            return buildForm(context, state.roundInfo.meals, state.roundInfo);
          }
          if (state is JugabilityNewRound) {
            // print('2');
            // print('JugabilityNewRound state');
            // print('New Round Info Month: ${state.actualMonth}');
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await showAnimatedPopup(context, state.actualMonth);
              // ignore: use_build_context_synchronously
              context
                  .read<JugabilityBloc>()
                  .add(NextRound(actualMonth: state.actualMonth));
            });
          }

          if (state is JugabilityInitial) {
            // print('0');
            List<bool> cardState = [false, false, false];
            List<bool> currentCardState = utilities.getCurrentCardsState();
            if (currentCardState.isEmpty) {
              utilities.saveCardState(cardState);
            }
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

          if (state is RoundInfoAfterTimeExpiration) {
            // print('actual estado: ${utilities.getCurrentCardsState()}');
            RoundInfoModel currentRoundInfo =
                utilities.getCurrentRoundInfoFromCache();
            List<bool> lastCardsState = utilities.getCurrentCardsState();
            List<MealModel> meals = currentRoundInfo.meals;
            List<MealModel> newMeals = state.roundInfo.meals;
            List<MealModel> mergeOfMeals =
                utilities.mergeMeals(lastCardsState, meals, newMeals);
            String lastMonth = currentRoundInfo.month;
            // print('RoundInfoAfterTimeExpiration state');
            // print('mes que me aparece en el cache despues de que el timer expiro: ${currentRoundInfo.month}');
            // print('estado de las cartas que me aparece en el cache despues de que el timer expiro: $lastCardsState');
            // print('comidas que me aparece en el cache despues de que el timer expiro: ${currentRoundInfo.meals[0].name} , ${currentRoundInfo.meals[1].name} , ${currentRoundInfo.meals[2].name}');
            // print('nuevas comidas solicitadas debido a la expiracion del timer: ${newMeals[0].name} , ${newMeals[1].name} , ${newMeals[2].name}');

            RoundInfoModel newRoundInfo = RoundInfoModel(
              calories: state.roundInfo.calories,
              taxes: state.roundInfo.taxes,
              month: lastMonth,
              meals: mergeOfMeals,
            );

            utilities.setLastMonth(lastMonth);

            utilities.saveCurrentRoundInfoInCache(newRoundInfo);

            return buildForm(context, mergeOfMeals, newRoundInfo);
          }
          // print('fuera de los estados');
          return const Center(
            child: Text('Error en la carga del menu'),
          );
        },
      ),
    );
  }

  Widget buildForm(
      BuildContext context, List<MealModel> meals, RoundInfo data) {
    // print('interfaz construida con el mes de: ${data.month}');
    double imageWith = MediaQuery.of(context).size.width / 3 - 40;
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
