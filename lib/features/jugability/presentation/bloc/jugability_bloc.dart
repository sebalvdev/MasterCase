// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:master_case/core/usecases/usecase.dart';
import 'package:master_case/features/jugability/domain/entities/meal.dart';

import '../../domain/entities/round_info.dart';
import '../../domain/usecases/get_info_round.dart' as get_info_round;
import '../../domain/usecases/next_info_round.dart' as next_info_round;

part 'jugability_event.dart';
part 'jugability_state.dart';

class JugabilityBloc extends Bloc<JugabilityEvent, JugabilityState> {
  final get_info_round.GetInfoRound getInfoRound;
  final next_info_round.NextInfoRound nextInfoRound;

  // final menuTest = [
  //   'assets/images/cocina.jpg',
  //   'assets/images/cocina.jpg',
  //   'assets/images/cocina.jpg'
  // ];
  JugabilityBloc({required this.getInfoRound, required this.nextInfoRound}) : super(JugabilityInitial()) {
    on<LoadGameEvent>((event, emit) async {
      emit(JugabilityLoading());
      print('load game event');      
      try {
        final result = await getInfoRound.call(NoParams());

        result.fold(
          (failure) => emit(JugabilityFailure()),
          (result) => emit(JugabilityLoaded(roundInfo: result)));
      } catch (e) {
        // emit(JugabilityFailure());
        print('Error en el bloc: $e');
      }
    });


    on<NextRound>((event, emit) async {
      emit(JugabilityLoading());

      print('Next round event');
      try {
        final result = await nextInfoRound.call(next_info_round.Params(month: event.actualMonth));

        result.fold((failure) => emit(JugabilityFailure()),

            
            (result) {
              if(result != null) {
                // print('Result: $result');
                // print('Result: ${result.meals}');
                emit(JugabilityLoaded(roundInfo: result));
              } else {
                emit(JugabilityFinish());
              }
            });
      } catch (e) {
        // emit(JugabilityFailure());
        print('Error en el bloc: $e');
      }
    });

    on<BetweenRounds>((event, emit) async {
      print('between rounds event');
      emit(JugabilityLoading());
      
      try {
        emit(JugabilityNewRound(actualMonth: event.actualMonth));
        // final result = await getInfoRound.call(NoParams());

        // result.fold((failure) => emit(JugabilityFailure()),
        //     (result) => emit(JugabilityLoaded(roundInfo: result)));
      } catch (e) {
        // emit(JugabilityFailure());
        print('Error en el bloc: $e');
      }
    });

    on<TimerExpiredEvent>((event, emit) async {
      emit(JugabilityLoading());
      final result = await getInfoRound.call(NoParams());
      result.fold(
        (failure) => emit(JugabilityFailure()),
        (result) => emit(RoundInfoAfterTimeExpiration(roundInfo: result)),
      );
      print('Timer expired');
    });
  }
}
